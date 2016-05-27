% HARRIS - Harris corner detector

% Basato sulla spiegazione fornito dall'assignment
% Implementazione e commenti in italiano di Illuminato Luca Costantino per il corso di 
% Computer Vision

% Questa funzione prende come parametri d'ingresso:
% un'immagine a scala di grigi
% una soglia per la "cornerness"
% sigma, cioè la deviazione standard di Gauss usata per smussare la matrice di covarianza (dato che siamo in 2D)
% radius, cioè il raggio della non-maximal suppression (cioè l'area in cui
% sopprimo tutta l'informazione che non appartiene al massimo locale).
% La funzione restituisce un array 2xN di coppie di punti che sono i nostri
% corner, inoltre mostra a schermo l'immagine con i corner sovraimpressi.

function [r,c] = luke_harris(im, threshold, sigma, radius)
    
    % Step 1: usiamo Sobel per calcolare le maschere di derivazione
    % dell'immagine (ci serviranno dopo).
    dx = [-1 0 1; -1 0 1; -1 0 1]; 
    dy = dx';
    % Step 2: calcolo Ix e Iy
    Ix = conv2(im, dx, 'same');    
    Iy = conv2(im, dy, 'same');    

    % Generiamo il filtro di smoothing gaussiano
    GS = fspecial('gaussian',max(1,fix(6*sigma)), sigma);
    
    % Calcoliamo le versioni smussate di Ix2, Iy2 e Ixy (praticamente
    % otteniamo una matrice di autocorrelazione).
    
    Ix_2 = conv2(Ix.^2, GS, 'same');
    Iy_2 = conv2(Iy.^2, GS, 'same');
    Ixy = conv2(Ix.*Iy, GS, 'same');
    
    k = 0.04; % il fattore k di M = det(A) - k * trace^2(A), posto a 0.04 come da suggerimento
    
    cornerness = (Ix_2.*Iy_2 - Ixy.^2) - k*(Ix_2 + Iy_2).^2; 

    % Step 7: faccio la non-maximal suppression come accennato prima
    
	mask_size = 2*radius+1;   % grandezza della maschera di lavoro
	filtrata = ordfilt2(cornerness,mask_size^2,ones(mask_size));
    % trovo i massimi locali
	cornerness = (cornerness==filtrata)&(cornerness>threshold);
	
    % coordinate dei punti
	[r,c] = find(cornerness);
	% mostro a schermo il risultato come da consegna
 	figure, imagesc(im), axis image, colormap(gray), hold on
	plot(c,r,'ys'), title('Corners Rilevati');
	
end
