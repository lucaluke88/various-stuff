function [FIS, FISA, locs, reducedMultispectralImage ] = spectral_analysis( input )
    
    % Costruisco la mappa delle variazioni
    FIS = buildFIS(input);
    
    % Creo un vettore che contiene la variazione globale per ogni livello
    FISA = buildNormalizedFISA(FIS);
    
    % Posso normalizzare i dati tra 0 e 1, tanto mi serve solo sapere la
    % posizione dei picchi di variazione.
    
    FISA = FISA/norm(FISA); 
    [~,locs] = findpeaks(FISA);
    
    % Adesso ho un primo partizionamento. Devo raffinarlo spostando i bordi
    % (tra gruppo e gruppo) in modo tale da minimizzare la varianza interna
    % di ogni gruppo. 
    % Per non complicarci la vita, procediamo così: scegliamo casualmente
    % un bordo e spostiamolo a destra di una posizione (cioè aggiungiamo
    % una banda al gruppo di sinistra). Se la varianza si è ridotta,
    % accetto il cambiamento, altrimenti lo rifiuto.
    % Tento questa operazione N volte, per esempio 1000.
    
    N = 1000; 
    
    for k=1:N
        % varianza intraclasse globale attuale
        varianza_intraclasse = getVarianzaGlobaleIntraClasse(locs,FISA);
        % propongo un nuovo partizionamento
        locs_tmp = locs;
        j = randi(size(locs,1),1,1); % l'indice della barra che sto per spostare
        locs_tmp(j) = locs_tmp(randi(size(locs,1),1,1)) + 1; % la sposto a destra di 1 posizione
        % se la nuova varianza globale è minore di prima confermo il
        % cambiamento
        if	getVarianzaGlobaleIntraClasse(locs_tmp,FISA) < varianza_intraclasse
            locs = locs_tmp;
        end
    end
    % Spostando i bordi, può capitare che si sovrappongano: togliamo dalla
    % lista dei bordi quelli con la stessa locazione fisica
    locs = unique(locs);
    
    % Costruisco una versione con meno livelli dell'immagine di input.
    % Mi serve nella fase di training.
    % Ad ogni livello k' associo la media dei valori di quel gruppo
    
    reducedMultispectralImage = zeros(size(input,1),size(input,2),size(locs,1)+1);
    for k=2:size(reducedMultispectralImage,3)+1
        %--------|-----------|-------------|------------
        for y=1:size(reducedMultispectralImage,1)
            for x=1:size(reducedMultispectralImage,2)
                reducedMultispectralImage(y,x,k) = mean(input(y,x,k-1:k));
            end
        end
        
    end
    
end



