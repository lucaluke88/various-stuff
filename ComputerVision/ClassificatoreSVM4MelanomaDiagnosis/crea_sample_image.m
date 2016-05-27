function [ input ] = crea_sample_image(num_foglietti)
    I = imread('onion.png');
    % costruiamoci un'immagine multispettrale in modo molto grezzo
    
    input = zeros(size(I,1),size(I,2),num_foglietti); % un numero minimo di foglietti per dare senso al test
    input(:,:,1:3) = I;
    for k = 4:num_foglietti
        input(:,:,k) = abs(I(:,:,randi([1 3],1,1)) - randi([0 255],1,1));
    end
end

