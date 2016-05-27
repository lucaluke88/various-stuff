%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

% Abilitiamo gli elementi grafici del menu e delle toolbar

function enableGuiElements(hObject, handles)
    
    try
        % Voci del menu
        set(handles.color_patch_sana,'Enable','on');
        set(handles.salva_con_nome,'Enable','on');
        set(handles.salva_lavoro,'Enable','on');
        set(handles.segmenta,'Enable','on');
        set(handles.segnarettangolo,'Enable','on');
        
        % abilito i pulsanti di marcatura
        set(handles.segnaoriginale_pellesana,'Visible','on');
        set(handles.segnaoriginale_pellemalata,'Visible','on');
        set(handles.segnapellesana_sana,'Visible','on');
        set(handles.segnapellesana_malata,'Visible','on');
        set(handles.segnapellemalata_sana,'Visible','on');
        set(handles.segnapellemalata_malata,'Visible','on');
        set(handles.cancella_orig,'Visible','on');
        set(handles.cancella_sana,'Visible','on');
        set(handles.cancella_malata,'Visible','on');
        
        % abilito le due anteprime
        set(handles.axes_preview_sana,'Visible','on');
        set(handles.axes_preview_malata,'Visible','on');
        guidata(hObject,handles);
        
        % abilito i campi personali
        
        set(handles.uipanel4,'Visible','on');
    catch
        disp('abilitazione elementi gui - enableGuiElements');
    end
end