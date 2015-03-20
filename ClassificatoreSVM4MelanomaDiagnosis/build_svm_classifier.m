function [svmClassifier,training_set] = build_svm_classifier(input, FIS, FISA)
    
    %   For training the SVM, we select one of
    %   the F I s (k) maps. This map can be the one revealing the most
    %	changes in the whole spectrum, i.e the global extrema of F I A s
    %	[...] .
    
    [k,~] = find(FISA==max(FISA(:))); % indice del foglietto di FIS con la varianza massima
    fisK = FIS(:,:,k);
    
    t = 0.5; % setting parameter, uso il valore citato nel paper
    T1 = mean2(fisK) + t * var(fisK(:)); %    T1 = mean(FIS) + t var(FIS)
    T2 = mean2(fisK) - t * var(fisK(:)); %    T2 = mean(FIS) - t var(FIS)
    
    %   Afterwards, in the selected map F I s (k), the N nearest
    %	pixels to the concerned threshold T 1 or T 2 are extracted for
    %	training the SVM. Among the N training pixels, half are se-
    %	lected above the threshold and half below the threshold.
    
    N = 50; % lo imposto io, nel paper non c'è scritto
    sorted = sort(reshape(fisK(:,:),[],1));
    sorted_over_t2 = sorted(sorted > T2);
    sorted_over_t2 = sorted_over_t2(1:N*0.5); % i primi N/2 sopra la soglia T2
    sorted_under_t2 = sorted(sorted <= T2);
    x = size(sorted_under_t2);
    sorted_under_t2 = sorted_under_t2(x - N*0.5:x); % i primi N/2 sotto la soglia T2
    
    training_set = zeros(N,2); % riga | colonna | pixel value
    training_set(1:N*0.5,:) = [sorted_over_t2,1];
    training_set(N*0.5+1:N) = [sorted_under_t2,0];
    % creo il classificatore
    svmClassifier = svmtrain(training_set(:,1),training_set(:,2));
end