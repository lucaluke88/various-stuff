%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
%
%
%% Marcatura dell'immagine in una figura esterna


function marcatura_azione(this_asse,this_etichetta,hObject,handles)
    
    global immagine;
    global asse;
    global etichetta;
   
    asse = this_asse;
    etichetta = this_etichetta;
    %immagine = handles.anteprima_marcature;
    switch asse
        case 'originale'
            immagine = handles.anteprima_marcature;
        case 'anteprima_sana'
            immagine = handles.anteprima_sana;
        case 'anteprima_malata'
            immagine = handles.anteprima_malata;
    end
    marcatura();
    imshow(immagine,'Parent',handles.axes_im_originale);
    
    guidata(hObject, handles);
end