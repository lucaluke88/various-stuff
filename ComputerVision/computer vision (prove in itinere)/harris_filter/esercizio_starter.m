% Implementazione di Illuminato Luca Costantino per Computer Vision
% Nell'ordine qui portato rileveremo i corner su varie immagini
clear all;
close all;
% dati forniti
threshold = 5e-4;
sigma = 3;
radius = 3;
% cominciamo ...

img_originale = imread('einstein.jpg');
c=luke_harris(img_originale,threshold,sigma,radius);


% ora ruoto Einstein di 45 gradi e faccio la stessa cosa

img_ruotata = imrotate(img_originale,45,'bilinear');
cr=luke_harris(img_ruotata,threshold,sigma,radius);

% moltiplico le intensità di 1.5
img_luminosa = img_originale * 1.5;
cl=luke_harris(img_luminosa,threshold,sigma,radius);

% ora riduco Einstein della metà
img_ridotta = imresize(img_originale,0.5,'bilinear');
crid=luke_harris(img_ridotta,threshold,sigma,radius);

figure;
subplot(2,2,1)
plot(c);
title('Originale');
subplot(2,2,2)
plot(cr);
title('Ruotata');
subplot(2,2,3)
plot(cl);
title('Più luminosa');
subplot(2,2,4)
plot(crid);
title('Ridotta');


