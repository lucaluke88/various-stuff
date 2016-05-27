function fast_export_workspace_Callback(hObject, eventdata, handles)
    try
        state = handles;
        state.function_entry_value = get(handles.popup_functions,'Value');
        state.metric_entry_value = get(handles.popup_similarity,'Value');
        state.F = find_function_line(textread(strcat('functions/',handles.function_name), '%s','delimiter', '\n'));
        state.M = find_function_line(textread(strcat('metrics/',handles.metric_name), '%s','delimiter', '\n'));
        save(fullfile('settings','current_workspace.mat'),'state');
        msgbox('Current state saved!');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
