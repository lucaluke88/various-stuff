%%  Estimating Camera Parameters – using a set of 3D world points and
%   their 2D image locations, estimate the projection matrix P of a camera.

clear all;
close all;
% importo i dati
world = load('world.txt');
image = load('image.txt');
% Rendo omogenee le coordinate reali e quelle proiettive
world = [world;ones(1,10)];
image = [image;ones(1,10)];

%  NB:  Il sistema l'ho ricavato manualmente seguendo la slide "Indirect 
%   Camera Calibration" in particolare le due equazioni fornite.
%
%  Ogni corrispondenza x(i) <--> X(i) mi fornisce due equazioni del tipo:
%  EQ1:     -X(i)p21 -Y(i)p22 -Z(i)p23 -p24 + y(i)X(i)p31 + y(i)Y(i)p32 +
%  y(i)Z(i)p33 + y(i)p34 = 0
%  EQ2:     -X(i)p11 - Y(i)p12 -Z(i)p13 -p14 + x(i)X(i)p31 + x(i)Y(i)p32 +
%   x(i)Z(i)p33 + x(i)p34 = 0
%  
%  (assumiamo w(i) = 1)
%
%  Il numero minimo di corrispondenze per risolvere il sistema lineare di
%  12 incognite pij è 6, noi ne abbiamo 10.
% Quindi, creiamo la matrice 20x12 dei coefficienti di pij e la chiamiamo
% A.
% Lo scopo è ottenere il sistema Ap = 0 e per ottenere il valore delle 12
% incognite senza incappare nella soluzione banale pij = 0 applichiamo SVD
% ad A.

A = zeros(20,12);
i=0;
for j=1:2:20
    i=i+1;
    A(j,:) = [0,0,0,0,-world(1,i),-world(2,i),-world(3,i),-1,image(2,i)*world(1,i),image(2,i)*world(2,i),image(2,i)*world(3,i),image(2,i)];
    A(j+1,:) = [-world(1,i),-world(2,i),-world(3,i),-1,0,0,0,0,image(1,i)*world(1,i),image(1,i)*world(2,i),image(1,i)*world(3,i),image(1,i)];
end

[~,~,V] = svd(A);
P = V(:, end);
P = reshape(P,4,3);
P=P';

% vedo se ho fatto bene

proiezione2D = ones(3,10);
for i=1:10
    w=world(:,i);
    punto_2D=image(:,i);
    pr=P*w;
    proiezione2D(1,i) = pr(1)/pr(3);
    proiezione2D(2,i) = pr(2)/pr(3);
end

% mostriamo a schermo lo scostamento tra pixel forniti del file "image.txt"
% con quelli proiettati da P * world
plot(proiezione2D(1,:),proiezione2D(2,:),'*');
hold on
plot(image(1,:),image(2,:),'o');
title('Differenza tra i punti 2D forniti in input e le proiezioni 2D calcolate');
legend('proiezioni','punti input');

%% un poco di pulizia
clear i;
clear V;

%% PUNTO B
[U,S,V] = svd(P);
% in questo caso considero l'ultima colonna di V per il null space
C=V(:,end);
%C = null(P); % eventuale verifica
% divido per il fattore di scala, in modo che w=1
C = C(:,1)/C(4,1); % <---- se non ho fatto errori il mio C dovrebbe essere questo