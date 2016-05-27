%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

function load_Callback(hObject, ~, handles)
    
    try
        load('lavoro');
        %%   se il lavoro riguarda l'intera immagine e non un suo ritaglio
        %    (oppure non ho immagini aperte su cui voglio appiccicare le modifiche)
        assignin('base','loaded_ris',risultato);
        handles.rect = risultato.rect;
        handles.filename = risultato.filename;
        
        handles.nomecognome = risultato.nomecognome;
        set(handles.edit2,'string',handles.nomecognome);
        handles.giorno = risultato.giorno;
        handles.mese = risultato.mese;
        handles.anno = risultato.anno;
        
        handles.patologia = risultato.patologia;
        
        if handles.immagine_aperta==0
            handles.immagine_originale = risultato.immagine_originale;
            handles.labels_output = risultato.labels_output;
            handles.labels_input = risultato.labels_input;
            handles.anteprima_marcature = risultato.anteprima_marcature;
            handles.anteprima_sana = risultato.anteprima_sana;
            handles.anteprima_malata = risultato.anteprima_malata;
            handles.fototipo = risultato.fototipo;
        else
            start_x = int16(handles.rect(1)); % x
            start_y = int16(handles.rect(2)); % y
            X2 = round(start_x + handles.rect(3));
            Y2 = round(start_y + handles.rect(4));
            % fondo labels
            handles.labels_input(start_y:Y2, start_x:X2) = risultato.labels_input;
            handles.anteprima_marcature(start_y:Y2, start_x:X2,:) = risultato.anteprima_marcature;
        end
        %updatePreviews(hObject,handles);
        imshow(handles.anteprima_marcature,'Parent',handles.axes_im_originale);
        imshow(handles.anteprima_sana,'Parent',handles.axes_preview_sana);
        imshow(handles.anteprima_malata,'Parent',handles.axes_preview_malata);
        
        
        set(handles.axes_preview_sana,'XTick',[]);
        set(handles.axes_preview_sana,'YTick',[]);
        set(handles.axes_preview_malata,'XTick',[]);
        set(handles.axes_preview_malata,'YTick',[]);
        
        handles.immagine_aperta = 1;
        enableGuiElements(hObject,handles);
        updateInfoImmagine(hObject,handles);
    catch
        disp('problema load_callback');
    end
    guidata(hObject, handles);
end