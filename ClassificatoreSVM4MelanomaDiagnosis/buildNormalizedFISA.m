function [FISA]=buildNormalizedFISA(mappaFIS)
    % Questa funzione mi crea un vettore con la varianza totale per livello
    % Accetta come input la mappa 3D delle varianze calcolate livello per
    % livello
    % L'ultima istruzione normalizza il vettore
    FISA = zeros(size(mappaFIS,3),1);
    for k=1:size(FISA,1)
        livello = mappaFIS(:,:,k);
        FISA(k) = sum(sum(livello(:)));
    end
    FISA = FISA/norm(FISA); 
end