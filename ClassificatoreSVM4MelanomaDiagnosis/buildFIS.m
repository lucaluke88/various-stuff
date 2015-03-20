function [ FIS ] = buildFIS( input )
    
    % Data un'immagine multispettrale, mi ricavo la mappa delle variazioni
    
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
    
end

