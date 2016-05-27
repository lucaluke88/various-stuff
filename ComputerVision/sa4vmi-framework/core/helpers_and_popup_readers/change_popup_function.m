function function_name = change_popup_function(hObject, ~, handles)
    try
        function_name = getCurrentPopupString(handles.popup_functions); % mi ricavo la voce scelta
        n_par = nargin(getFunctionHandleFromFile(fullfile('functions',function_name)));
        handles.F = find_function_line(textread(fullfile('functions',function_name), '%s','delimiter', '\n'));
        n = 9; % numero input box disponibili (uno è l'immagine, quindi in realtà al massimo abbiamo 8 parametri)
        
        num_box_da_abilitare = min(n,n_par); % abilito fino al massimo di 8 caselle
        
        % abilito le voci di input che mi servono ...
        
        for i=2:num_box_da_abilitare
            disp(strcat('abilito input_text_',num2str(i)));
            set(findobj('Tag',strcat('input_text_',num2str(i))),'String',handles.F(i)); % cambio il nome dell'input box leggendo dalla funzione
            set(findobj('Tag',strcat('input_text_',num2str(i))),'Visible','On');
            set(findobj('Tag',strcat('edit_text_',num2str(i))),'Visible','On');
        end
        
        % ... e pulisco i box che non mi servono
        
        if(num_box_da_abilitare<n)
            for j = num_box_da_abilitare+1 : n
                disp(strcat('disabilito input_text_',num2str(j)));
                set(findobj('Tag',strcat('input_text_',num2str(j))),'String',strcat('input_text_',num2str(j))) % cambio il nome dell'input box leggendo dalla funzione
                set(findobj('Tag',strcat('input_text_',num2str(j))),'Visible','Off');
                set(findobj('Tag',strcat('edit_text_',num2str(j))),'Visible','Off');
            end
        end
        
        guidata(hObject,handles);
    catch error
        disp(getReport(error,'basic','hyperlinks','off'));
    end
end