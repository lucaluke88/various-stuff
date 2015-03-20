function [ reducedImage, FIS, FISA, locs ] = spectral_analysis( input )
    
    % Questa funzione mi deve ridurre il numero di foglietti dell'immagine
    % mantenendo solo quelli più informativi.
    % I valori dei foglietti rimasti non saranno esattamente quelli
    % originali, ma la media di una regione di foglietti con una varianza
    % più piccola possibile.

    % dimensioni dell'input
    larghezza_input = size(input,2);
    altezza_input = size(input,1);
    numero_bande = size(input,3);
    
    % mappa delle variazioni
    FIS = zeros(altezza_input,larghezza_input,numero_bande-1); % mappa delle variazioni puntuali
    for k=2:numero_bande
        % dato il pixel di coordinate (i,j) mi determino il suo 3-vicinato
        % (cioè l'intorno 3x3) sia nel livello k che in quello k-1 e sommo
        % i valori assoluti delle differenze punto a punto.
        for i=2:altezza_input-1 % non considero i pixel di bordo
            for j=2:larghezza_input-1 % (essendo immagini grandi, me lo posso permettere)
                k_vicinato = [input(i-1,j-1,k), input(i-1,j,k), input(i-1,j+1,k);
                    input(i,j-1,k), input(i,j,k), input(i,j+1,k);
                    input(i+1,j-1,k), input(i+1,j,k), input(i+1,j+1,k)];
                k_meno_uno_vicinato = [input(i-1,j-1,k-1), input(i-1,j,k-1), input(i-1,j+1,k-1);
                    input(i,j-1,k-1), input(i,j,k-1), input(i,j+1,k-1);
                    input(i+1,j-1,k-1), input(i+1,j,k-1), input(i+1,j+1,k-1)];
                % scrivo (k-1) perchè parto da 2
                FIS(i,j,k-1) = sum(sum(abs(k_vicinato - k_meno_uno_vicinato)));
            end
        end
    end
    
    % integro spazialmente ogni foglietto, ricavandomi un vettore FISA(k) a
    % cui corrisponde la somma di tutti i valori di FIS(k)
    
    FISA = zeros(numero_bande-1,1);
    for k=1:numero_bande-1
        FISA(k) = sum(sum(FIS(:,:,k)));
    end
    FISA = FISA/norm(FISA); % normalizzo FISA, mi servono solo le differenze relative
    [~,locs] = findpeaks(FISA);  % trovo le locazioni dei picchi di FISA
    
    % Gli elementi di 'locs' sono i bordi di K gruppi. Voglio raffinare il
    % mio partizionamento in modo tale da ottenere K' gruppi con una
    % varianza interna minima.
   
    % Faccio TOT volte questa operazione: scelgo un bordo a caso e lo
    % sposto a destra di un'unità. Se ho ridotto la varianza (intraclasse)
    % totale, bene! Confermo la mia scelta e vado avanti. Altrimenti
    % rifiuto la modifica e proseguo. Per forza di cose, otterrò un
    % partizionamento migliore di quello iniziale ma non ottimale, dato che
    % sto usando un metodo non particolarmente evoluto.
    
    n_interazioni = 1000; 
    for k=1:n_interazioni
        varianza_intraclasse = getVarianzaGlobaleIntraClasse(locs,FISA); % varianza totale corrente
        locs_tmp = locs; % il nuovo partizionamento proposto
        locs_tmp(randi(size(locs,1),1,1)) = locs_tmp(randi(size(locs,1),1,1)) + 1;
        if	getVarianzaGlobaleIntraClasse(locs_tmp,FISA) < varianza_intraclasse
            locs = locs_tmp;
        end
    end
    locs = unique(locs); % togliamo gli indici duplicati (bordi sovrapposti)
    
    
    % Ora so come ridurre l'immagine. "Fondo" ogni regione in un singolo
    % foglietto facendo la media dei pixel di medesima posizione (i,j)
    reducedImage = zeros(altezza_input,larghezza_input,size(locs,1));
    for k=2:size(locs,1)
        % al livello k, scrivo nella locazione (i,j) la media dei pixel di
        % questo gruppo
        for i=1:altezza_input
            for j=1:larghezza_input
                % k-1 perchè parto da 2
                reducedImage(i,j,k-1) = mean(input(i,j,locs(k-1):locs(k)));
            end
        end
        
    end
    
    
    hold off;
end


function varianza_intraclasse = getVarianzaGlobaleIntraClasse(locs,FISA)
    
    varianza_intraclasse = 0;
    k = 1;
    for k=1:size(locs,1) - 1
        
        % misuro la varianza del gruppo dal segnaposto K a K+1 e l'aggiungo
        % alla stima generale
        try
            varianza_intraclasse = varianza_intraclasse + var(FISA(locs(k):locs(k+1)));
        catch e
            disp (e.getMessage());
        end
        
    end
    
end

