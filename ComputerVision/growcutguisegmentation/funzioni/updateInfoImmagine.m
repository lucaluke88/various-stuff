function updateInfoImmagine(hObject,handles)
    
    
    [nRows,nCols,~] = size(handles.immagine_originale);
    if length(handles.filename) <= 20
        info_immagine = handles.filename;
    else
        info_immagine = handles.filename(1:17);
        info_immagine = strcat(info_immagine,'...');
    end
    info_immagine = strcat(info_immagine,'\n',num2str(nRows),'x',num2str(nCols),'\n');
    
    set(handles.info_box,'String',sprintf(info_immagine));
    guidata(hObject,handles);
end

