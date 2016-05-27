%% Scale-invariance using Laplacian and DoG operators
% Implementazione di Illuminato Luca Costantino per Computer Vision

clear all;
close all;
img = imread('einstein.jpg');
img_ridotta = imresize(img, 0.5);
fixed_location = [186 148];

dxx = [1 -2 1];
dyy = [1 -2 1]';

sigma = 3;

% location 186,148
valori = zeros(31,5);
i = 1;
for(i=1:31)
    % costruzione del filtro LoG e LoG normalizzato al variare di sigma
    sigma = 2.6 + i*0.4;
    GS = fspecial('gaussian',round(6*sigma), sigma);
    GSxx = conv2(GS,dxx,'valid');
    GSyy = conv2(GS,dyy,'valid');
    rect = [1 1 15 15];
    GSxx = imcrop(GSxx,rect);
    GSyy = imcrop(GSyy,rect);
    laplacian_of_gaussian = GSxx + GSyy; % LoG non normalizzato
    sn_lg = sigma^2 * laplacian_of_gaussian; % LoG normalizzato per la scala
    
    %% applico i due filtri alle due immagini e salvo i valori della locazione indicata
    
    img_filt = conv2(img,laplacian_of_gaussian); % immagine grande con LoG
    img_filt_norm = conv2(img,sn_lg); % immagine grande con LoG normalizzato
    img_ridotta_filt = conv2(img_ridotta,laplacian_of_gaussian); % immagine piccola con LoG
    img_ridotta_filt_norm = conv2(img_ridotta,sn_lg); % immagine piccola con LoG normalizato
       
    valori(i,:) = [sigma img_filt(186,148) img_ridotta_filt(93,74) img_filt_norm(186,148) img_ridotta_filt_norm(93,74)];
    
end

figure('Name','Esercizio 3');
subplot(2,2,1);
h1 = plot(valori(:,1),valori(:,2),'color','r'); hold on
h2 = plot(valori(:,1),valori(:,3),'color','b');
title('LoG');
legend([h1 h2],{'Immagine', 'Immagine Ridotta'});
xlabel('sigma');
subplot(2,2,2);
h1 = plot(valori(:,1),valori(:,4),'color','r'); hold on
h2 = plot(valori(:,1),valori(:,5),'color','b');
title('LoG Normalizzato');
legend([h1 h2],{'Immagine', 'Immagine Ridotta'});
xlabel('sigma');
% prima immagine
subplot(2,2,3);
imshow(img); hold on
%e
r= max(valori(:,4));
x = 148;
y = 186;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,'color','y');

title('Einstein');
% seconda immagine
subplot(2,2,4);
imshow(img_ridotta); hold on
%e
r= max(valori(:,5));
x = 74;
y = 93;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit,'color','y');

title('Einstein 50%');