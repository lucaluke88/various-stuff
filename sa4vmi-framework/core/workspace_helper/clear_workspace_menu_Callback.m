function clear_workspace_menu_Callback(hObject, eventdata, handles)
    try
        inizialize_workspace(hObject, eventdata, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end