%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
%%
function toggleButtons(asse,pulsante,hObject,handles)
    
    set(handles.segnaoriginale_pellesana,'Enable','off');
    set(handles.segnaoriginale_pellemalata,'Enable','off');
    set(handles.segnapellesana_sana,'Enable','off');
    set(handles.segnapellesana_malata,'Enable','off');
    set(handles.segnapellemalata_sana,'Enable','off');
    set(handles.segnapellemalata_malata,'Enable','off');
    set(handles.cancella_orig,'Enable','off');
    set(handles.cancella_sana,'Enable','off');
    set(handles.cancella_malata,'Enable','off');
    
    switch asse
        case 'originale'
            set(handles.end_selection,'Enable','on');
            switch pulsante
                case 'sana'
                    set(handles.segnaoriginale_pellesana,'Enable','on');
                    etichetta('sana','immagine_originale',hObject,handles);
                case 'malata'
                    set(handles.segnaoriginale_pellemalata,'Enable','on');
                    etichetta('malata','immagine_originale',hObject,handles);
                case 'cancella'
                    set(handles.cancella_orig,'Enable','on');
                    etichetta('cancella','immagine_originale',hObject,handles);
            end
        case 'anteprima_sana'
            set(handles.end_selection,'Enable','on');
            switch pulsante
                case 'sana'
                    set(handles.segnapellesana_sana,'Enable','on');
                    etichetta('sana','anteprima_sana',hObject,handles);
                case 'malata'
                    set(handles.segnapellemalata_sana,'Enable','on');
                    etichetta('malata','anteprima_sana',hObject,handles);
                case 'cancella'
                    set(handles.cancella_sana,'Enable','on');
                    etichetta('cancella','anteprima_sana',hObject,handles);
            end
        case 'anteprima_malata'
            set(handles.end_selection,'Enable','on');
            switch pulsante
                case 'sana'
                    set(handles.segnapellesana_malata,'Enable','on');
                    etichetta('sana','anteprima_malata',hObject,handles);
                case 'malata'
                    set(handles.segnapellemalata_malata,'Enable','on');
                    etichetta('malata','anteprima_malata',hObject,handles);
                case 'cancella'
                    set(handles.cancella_malata,'Enable','on');
                    etichetta('cancella','anteprima_malata',hObject,handles);
            end
        case 'reset'
            set(handles.end_selection,'Enable','off');
            set(handles.segnaoriginale_pellesana,'Enable','on');
            set(handles.segnaoriginale_pellemalata,'Enable','on');
            set(handles.segnapellesana_sana,'Enable','on');
            set(handles.segnapellesana_malata,'Enable','on');
            set(handles.segnapellemalata_sana,'Enable','on');
            set(handles.segnapellemalata_malata,'Enable','on');
            set(handles.cancella_orig,'Enable','on');
            set(handles.cancella_sana,'Enable','on');
            set(handles.cancella_malata,'Enable','on');
    end
%     guidata(hObject, handles);
end