function [svmClassifier,best_set] = build_svm_classifier(input, FIS, FISA)
    
    %% Selezioniamo il livello k di FIS più interessante, cioè quello il cui valore di FISA è massimo
    
    k = FISA==max(FISA);
    fisK = FIS(:,:,k);
    
    %% Impostiamo una soglia per i pixel più significativi che andranno a comporre il nostro training set
    t = 0.5; % Setting parameter, uso quello del paper
    T1 = mean2(fisK) + t * var(fisK(:)); %
    
    %% Prendiamo a questo punto N/2 pixels sopra la soglia e N/2 sotto
    N = 50; % leggo dal paper
    % ordino in ordine crescente i valori di fisK
    
    %% Costruisco il mio 'DB' delle osservazioni, cioè [y,x,fisK(y,x)]
    
    osservazioni = zeros(size(FIS,1)*size(FIS,2),3);
    cont = 0;
    for y=1:size(FIS,1)
        for x=1:size(FIS,2)
            cont = cont + 1;
            osservazioni(cont,:) = [y,x,fisK(y,x)];
        end
    end
    
    %% Le ordino in senso crescente di fisK
    osservazioni = sortrows(osservazioni,3);
    
    %% Costruisco un training set con questi punti significativi
    %  Ragionamento: i pixel che vanno da T1 in su appartengono alla regione "anomala"
    %   Cioè sono quelli col melanoma. Quelli sotto li posso supporre 'sani'.
    
    idx =   osservazioni(:,3)>T1;
    tmp = osservazioni(idx,:);
    best_set(:,1:N/2) = tmp(:,1:N/2);
    idx =   osservazioni(:,3)<T1;
    tmp = osservazioni(idx,:);
    best_set(:,N/2+1:end) = tmp(:,N/2+1:end);
    
    %% Adesso da un training set composto solo dall'informazione di fisK 
    %  passo ad un training set con le informazioni dei K+1 gruppi 
    %  (che sono le mie vere features)
    
    training_set = zeros(N,3+k); % k+1 gruppi e 2 per le coordinate
    for k=1:size(training_set,3)
        training_set(k,:) = [best_set(k,1),best_set(k,2),input(k,:)]; % y|x|riga immagine di input
    end
    
    for i = 1:N/2
        labels(i) = 'Melanoma';
    end
    
    for i = N/2+1:N
        labels(i) = 'Sana';
    end
    
    % creo il classificatore
    svmClassifier = svmtrain(training_set,labels);
end