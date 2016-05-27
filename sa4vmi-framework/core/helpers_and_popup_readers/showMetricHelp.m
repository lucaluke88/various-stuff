function showMetricHelp(hObject, eventdata, handles)
    try
    [help_content,help_found] = parse_metric_help(handles.metric_name);
    if(help_found)
        set(findobj('Tag','uipanel17'),'Title','Help file content');
        set(findobj('Tag','info_metric_box'),'FontWeight','bold');
    else
        set(findobj('Tag','uipanel17'),'Title','Code (help file not found)');
        set(findobj('Tag','info_metric_box'),'ForegroundColor','white');
        set(findobj('Tag','info_metric_box'),'BackgroundColor','black');
    end
    set(findobj('Tag','info_metric_box'),'String',help_content);
    guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
