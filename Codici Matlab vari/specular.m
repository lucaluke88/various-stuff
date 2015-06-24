%% Specular: un semplice script di Luca Luke Costantino
% con questo script è possibile "estendere" un'immagine fino a farla
% diventare delle dimensioni di uno sfondo con un effetto specchiato.

%% importo l'immagine
clear all;
close all;
[filename,pathname] = uigetfile({'*.jpg';'*.png';'*.bmp'}); 
immagine=imread(strcat(pathname,'/',filename)); %reading your .jpg image
% scelgo le dimensioni dello sfondo
prompt = {'Larghezza :','Altezza:'};
dlg_title = 'Dimensioni sfondo';
num_lines = 1;
def = {'1280','960'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
%%
larghezza_sfondo = str2double(cell2mat(def(1)));
altezza_sfondo = str2double(cell2mat(def(2)));
sfondo = uint8(zeros(altezza_sfondo,larghezza_sfondo,3));
[altezza_immagine,larghezza_immagine,dim] = size(immagine);
%% comincia la costruzione del wallpaper
angolosx = int32([(altezza_sfondo-altezza_immagine)*0.5,(larghezza_sfondo-larghezza_immagine)*0.5]);
sfondo((angolosx(1)+1):(angolosx(1)+altezza_immagine),(angolosx(2)+1):(angolosx(2)+larghezza_immagine),:) = immagine(:,:,:);

%% sinistro
for i=1:altezza_sfondo
    for j=1:angolosx(2);
        sfondo(i,angolosx(2)-j+1,:) = sfondo(i,j+angolosx(2),:);
    end
end

%% destro

for i=1:altezza_sfondo
    k = 1;
    for j=angolosx(2)+larghezza_immagine:larghezza_sfondo;
        k = k + 1;
        sfondo(i,j,:) = sfondo(i,angolosx(2)+larghezza_immagine-k,:);
    end
end

% sopra

for i = 1 : angolosx(1) - 1
    sfondo(i,:,:) = sfondo(2*angolosx(1)-i,:,:);
end

% sotto

k = 1;
for i = 1 : angolosx(1) - 1
    
    sfondo(altezza_immagine+angolosx(1)+i,:,:) = sfondo(altezza_immagine+angolosx(1)-k,:,:);
    k = k+1;
end

imwrite(sfondo,strcat(pathname,'/',filename,'_edit'),'jpeg');