%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
%%
function segna_area(hObject, ~, handles)
    
    try
        axes(handles.axes_immagine_originaleinale);
        
        [handles.immagine_originale, handles.rect] = imcrop(handles.immagine_originale);
        handles.anteprima_marcature = handles.immagine_originale;
        handles.anteprima_malata = handles.immagine_originale*0;
        handles.anteprima_sana = handles.immagine_originale*0;
        
        [nRows,nCols] = size(handles.immagine_originale);
        handles.labels_input = zeros(nRows,nCols,'double');
        % mostro le immagini
        imshow(handles.immagine_originale,'Parent',handles.axes_immagine_originaleinale);
        imshow(handles.anteprima_sana,'Parent',handles.axes_preview_sana);
        imshow(handles.anteprima_malata,'Parent',handles.axes_preview_malata);
        
        updateInfoImmagine(hObject,handles);
        
    catch
        disp('problema ritaglia area - segna_area');
    end
    guidata(hObject, handles);
end
