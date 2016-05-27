%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

function apri_immagine_Callback(hObject, ~, handles)

    global main_fig_handle;
    try
        [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.bmp'},'Apri immagine');
        handles.filename = FileName;
        handles.immagine_aperta = 1;
        handles.immagine_originale = uint8(imread(fullfile(PathName, FileName)));
        
        handles.anteprima_sana = handles.immagine_originale*0;
        handles.anteprima_malata = handles.immagine_originale*0;
        handles.anteprima_marcature = handles.immagine_originale;
        [m,n,~] = size(handles.immagine_originale);
        handles.labels_input = zeros(m,n,'double');
        disp('Labels appena creata');
        disp(unique(handles.labels_input));
        handles.labels_output = handles.labels_input;
        handles.rect = [0 0 0 0];
        
        enableGuiElements(hObject,handles);
        updateInfoImmagine(hObject,handles);
        
        imshow(handles.immagine_originale,'Parent',handles.axes_im_originale);
        imshow(handles.anteprima_sana,'Parent',handles.axes_preview_sana);
        imshow(handles.anteprima_malata,'Parent',handles.axes_preview_malata);
        main_fig_handle = handles; % per l'altra GUI
        
        guidata(hObject,handles);
        
    catch
        disp('errore apertura immagine - apri_immagine');
    end
end
