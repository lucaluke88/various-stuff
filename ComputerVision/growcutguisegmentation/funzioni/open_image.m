%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

function open_image(hObject, handles)
    
    [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.bmp'},'Apri immagine');
    
    if exist(fullfile(PathName, FileName),'file') == 2 % la risorsa esiste ed è un file
        
        handles.filename = FileName;
        handles.immagine_aperta = 1;
        handles.immagine_originale = uint8(imread(fullfile(PathName, FileName)));
        handles.anteprima_sana = handles.immagine_originale*0;
        handles.anteprima_malata = handles.immagine_originale*0;
        handles.anteprima_marcature = handles.immagine_originale;
        [m,n,~] = size(handles.immagine_originale);
        handles.labels_input = zeros(m,n,'double');
        handles.labels_output = handles.labels_input;
        handles.rect = [0 0 0 0];
        
        enableGuiElements(hObject,handles);
        updateInfoImmagine(hObject,handles);
        
        imshow(handles.immagine_originale,'Parent',handles.axes_im_originale);
        imshow(handles.anteprima_sana,'Parent',handles.axes_preview_sana);
        imshow(handles.anteprima_malata,'Parent',handles.axes_preview_malata);
        
        set(handles.text8,'String',sprintf('Scegli che tipo di pelle stai marcando con gli appositi pulsanti sopra le anteprime.\nPuoi selezionare più aree (della stessa categoria) in sequenza.'));
        guidata(hObject,handles);
    end
end
