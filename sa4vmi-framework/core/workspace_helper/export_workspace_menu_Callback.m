function export_workspace_menu_Callback(hObject, eventdata, handles)
    % hObject    handle to export_workspace_menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    try
    [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
    state = handles;
    state.function_entry_value = get(handles.popup_functions,'Value');
    state.metric_entry_value = get(handles.popup_similarity,'Value');
    state.F = find_function_line(textread(fullfile('functions',handles.function_name), '%s','delimiter', '\n'));
    state.M = find_function_line(textread(fullfile('metrics',handles.metric_name), '%s','delimiter', '\n'));
    save(fullfile(PathName,FileName),'state');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end