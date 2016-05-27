function showHelp(hObject, eventdata, handles)
    try
    [help_content,help_found] = parse_help(handles.function_name);
    if(help_found)
        set(findobj('Tag','uipanel15'),'Title','Help file content');
        set(findobj('Tag','info_box'),'FontWeight','bold');
    else
        set(findobj('Tag','uipanel15'),'Title','Code (help file not found)');
        set(findobj('Tag','info_box'),'ForegroundColor','white');
        set(findobj('Tag','info_box'),'BackgroundColor','black');
    end
    set(findobj('Tag','info_box'),'String',help_content);
    guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end