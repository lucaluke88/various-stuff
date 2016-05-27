%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
%%
function updatePreviews(hObject,handles)
    try
        handles.anteprima_sana = handles.immagine_originale; % ripristiniamo le anteprime
        handles.anteprima_malata = handles.immagine_originale; % ripristiniamo le anteprime
        
        handles.anteprima_sana(:,:,1) = handles.anteprima_sana(:,:,1) .* uint8(handles.labels_output);
        handles.anteprima_sana(:,:,2) = handles.anteprima_sana(:,:,2) .* uint8(handles.labels_output);
        handles.anteprima_sana(:,:,3) = handles.anteprima_sana(:,:,3) .* uint8(handles.labels_output);
        
        handles.anteprima_malata(:,:,1) = handles.anteprima_malata(:,:,1) .* uint8(~handles.labels_output);
        handles.anteprima_malata(:,:,2) = handles.anteprima_malata(:,:,2) .* uint8(~handles.labels_output);
        handles.anteprima_malata(:,:,3) = handles.anteprima_malata(:,:,3) .* uint8(~handles.labels_output);
        
        imshow(handles.anteprima_marcature,'Parent',handles.axes_im_originale);
        imshow(handles.anteprima_sana,'Parent',handles.axes_preview_sana);
        imshow(handles.anteprima_malata,'Parent',handles.axes_preview_malata);
    catch
        disp('problema anteprima - updatePreviews');
    end
    guidata(hObject,handles);
end