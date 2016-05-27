function salva_con_nome_Callback(hObject, ~, handles)
    
    try
        
        [file,path] = uiputfile('*.mat','Salva lavoro come');
        
        
        risultato.immagine_aperta = handles.immagine_aperta;
        risultato.immagine_originale = handles.immagine_originale;
        risultato.anteprima_sana = handles.anteprima_sana;
        risultato.anteprima_malata = handles.anteprima_malata;
        risultato.anteprima_marcature = handles.anteprima_marcature;
        risultato.labels_input = handles.labels_input;
        risultato.labels_output = handles.labels_output;
        risultato.rect = handles.rect;
        risultato.filename = handles.filename;
        risultato.nomecognome = handles.nomecognome;
        
        risultato.giorno = handles.giorno;
        risultato.mese = handles.mese;
        risultato.anno = handles.anno;
        
        risultato.patologia = handles.patologia;
        
        assignin('base','risultato',risultato);
        save(fullfile(path,file),'risultato');
        msgbox('Lavoro salvato!');
    catch
        disp('problema salva con nome - salve_con_nome');
    end
    guidata(hObject,handles);
end