function [FISA]=buildFISA(mappaFIS)
    % Questa funzione mi crea un vettore con la varianza totale per livello
    % Accetta come input la mappa 3D delle varianze calcolate livello per
    % livello
    FISA = zeros(size(mappaFIS,3));
    for k=1:size(FISA,1)
        livello = mappaFIS(:,:,k);
        FISA(k) = sum(livello(:));
    end
end