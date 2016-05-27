%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

function export(hObject, ~, handles)
    
    risultato.immagine_aperta = handles.immagine_aperta;
    risultato.immagine_originale = handles.immagine_originale;
    risultato.anteprima_sana = handles.anteprima_sana;
    risultato.anteprima_malata = handles.anteprima_malata;
    risultato.anteprima_marcature = handles.anteprima_marcature;
    risultato.labels_input = handles.labels_input;
    risultato.labels_output = handles.labels_output;
    risultato.rect = handles.rect;
    risultato.filename = handles.filename;
    risultato.fototipo = handles.fototipo;
    risultato.nomecognome = handles.nomecognome; 
    
    risultato.giorno = handles.giorno;
    risultato.mese = handles.mese;
    risultato.anno = handles.anno;
    
    risultato.patologia = handles.patologia;
    
    assignin('base','risultato',risultato);
    save('lavoro','risultato');
    msgbox('Lavoro salvato!');
    guidata(hObject,handles);
end