
function metric_name = change_popup_metric(hObject, ~, handles)
    try
        metric_name = getCurrentPopupString(handles.popup_similarity); % mi ricavo la voce scelta
        n_par = nargin(getFunctionHandleFromFile(fullfile('metrics',metric_name)));
        handles.M = find_function_line(textread(fullfile('metrics',metric_name), '%s','delimiter', '\n'));
        
        n = 10; % numero input box disponibili (uno è l'immagine, quindi in realtà al massimo abbiamo 8 parametri)
        
        num_box_da_abilitare = min(n,n_par-2);
        % abilito le voci di input che mi servono ...
        if(num_box_da_abilitare>0)
            for i=1:num_box_da_abilitare
                set(findobj('Tag',strcat('similarity_input_name_',num2str(3+i))),'String',handles.M(2+i)); % cambio il nome dell'input box leggendo dalla funzione
                set(findobj('Tag',strcat('similarity_input_name_',num2str(3+i))),'Visible','On');
                set(findobj('Tag',strcat('metric_edit_',num2str(3+i))),'Visible','On');
                
            end
            
            if(num_box_da_abilitare<n)
                for j = 4+num_box_da_abilitare : n
                    set(findobj('Tag',strcat('similarity_input_name_',num2str(j))),'String',strcat('input_text_',num2str(j))) % cambio il nome dell'input box leggendo dalla funzione
                    set(findobj('Tag',strcat('similarity_input_name_',num2str(j))),'Visible','Off');
                    set(findobj('Tag',strcat('metric_edit_',num2str(j))),'Visible','Off');
                end
            end
        else
            for j=4:n
                set(findobj('Tag',strcat('similarity_input_name_',num2str(j))),'String',strcat('input_text_',num2str(j))) % cambio il nome dell'input box leggendo dalla funzione
                set(findobj('Tag',strcat('similarity_input_name_',num2str(j))),'Visible','Off');
                set(findobj('Tag',strcat('metric_edit_',num2str(j))),'Enable','Off');
            end
        end
        
        guidata(hObject,handles);
    catch error
        disp(getReport(error,'basic','hyperlinks','off'));
    end
end