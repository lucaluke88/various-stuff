% Esercizio 1: colorazione di foto mediante finestra di shift
% Implementazione di Illuminato Luca Costantino per Computer Vision


clear all;
close all;

% faccio scegliere all'utente il file e la modalità da usare
[img_input, pathname] = ...
     uigetfile({'*.jpg';'*.gif';'*.png';'*.tiff'},'File Selector');
 
 mode = 0; % automatico
% imname = 'part1_4'; % name of the input file

%% Seguiamo i suggerimenti scritti nel file allegato all'assignment

%img_input = strcat(imname,'.jpg');
fullim = imread(img_input); % read in the image
fullim = im2double(fullim); % convert to double matrix
height = floor(size(fullim,1)/3); % compute the height of each part (just 1/3 of total)
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

shift_riga_rossa_stringa = '';
shift_colonna_rossa_stringa = '';
shift_riga_verde_stringa = '';
shift_colonna_verde_stringa = '';


if(mode == 1)
    [patch,rect_patch] = imcrop(B); % selezione manuale
%     figure('Name','Patch scelta');imshow(patch);
    % ROSSO
    c = normxcorr2(patch,R);
    [ypeak, xpeak] = find(c==max(c(:)));
    yoffSet = ypeak-size(patch,1);
    xoffSet = xpeak-size(patch,2);
    shift_x = uint8(rect_patch(1)-xoffSet);
    shift_y = uint8(rect_patch(2)-yoffSet);
    R = circshift(R,[shift_y shift_x]);
    
    % VERDE
    c = normxcorr2(patch,G);
    [ypeak, xpeak] = find(c==max(c(:)));
    yoffSet = ypeak-size(patch,1);
    xoffSet = xpeak-size(patch,2);
    shift_x = uint8(rect_patch(1)-xoffSet);
    shift_y = uint8(rect_patch(2)-yoffSet);
    G = circshift(G,[shift_y shift_x]);
    rgb_img = cat(3,R,G,B);
    
    
else if (mode == 0)
        ssd_minimo = 0;
        finestra = 10;
        for shift_riga = -finestra:finestra
            for shift_colonna = -finestra:finestra
                immagine_shiftata = circshift(single(R), [shift_riga, shift_colonna]);
                ssd_tmp = sum(sum((immagine_shiftata - B).^2));
                if ssd_minimo == 0 % direttamente posso sostituire il valore
                    ssd_minimo = ssd_tmp;
                    R_spostato = immagine_shiftata;
                    shift_riga_rossa_stringa = num2str(shift_riga);
                    shift_colonna_rossa_stringa = num2str(shift_colonna);
                else if ssd_tmp < ssd_minimo % aggiorno l'SSD
                        ssd_minimo = ssd_tmp;
                        R_spostato = immagine_shiftata;
                        shift_riga_rossa_stringa = num2str(shift_riga);
                        shift_colonna_rossa_stringa = num2str(shift_colonna);
                    end
                end
            end
        end
        % faccio lo stesso per il canale verde
        for shift_riga = -finestra:finestra
            for shift_colonna = -finestra:finestra
                immagine_shiftata = circshift(single(G), [shift_riga, shift_colonna]);
                ssd_tmp = sum(sum((immagine_shiftata - B).^2));
                if ssd_minimo == 0 % direttamente posso sostituire il valore
                    ssd_minimo = ssd_tmp;
                    G_spostato = immagine_shiftata;
                    shift_riga_verde_stringa = num2str(shift_riga);
                    shift_colonna_verde_stringa = num2str(shift_colonna);
                else if ssd_tmp < ssd_minimo % aggiorno l'SSD
                        ssd_minimo = ssd_tmp;
                        G_spostato = immagine_shiftata;
                        shift_riga_verde_stringa = num2str(shift_riga);
                        shift_colonna_verde_stringa = num2str(shift_colonna);
                    end
                end
            end
        end
        rgb_img = cat(3,R_spostato,G_spostato,B);
    end
end

% % output
figure('Name','Immagine Shiftata');
imshow(rgb_img);
title(strcat('Shift rosso=(',shift_riga_rossa_stringa,',',shift_colonna_rossa_stringa,') Shift verde=(',shift_riga_verde_stringa,',',shift_colonna_verde_stringa,')'));
imwrite(rgb_img,strcat('output_',img_input),'jpeg');