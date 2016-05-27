%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function previous_input_image_button_Callback(hObject, eventdata, handles)
    try
        if(handles.input_image_cursor==1)
            handles.input_image_cursor = size(handles.FileName,2);
        else
            handles.input_image_cursor = handles.input_image_cursor - 1;
        end
        axes(handles.input_image_axes);
        imshow(handles.input_image{handles.input_image_cursor}, []);
        % filename label with rgb/gray info
        if is_rgb(handles.input_image) == 1
            image_name = strcat(strcat({handles.FileName{1}},{'  '},{strcat('(',num2str(handles.input_image_cursor),'/',num2str(size(handles.FileName,2)),')')}),' [RGB]');
        else
            image_name = strcat(strcat({handles.FileName{1}},{'  '},{strcat('(',num2str(handles.input_image_cursor),'/',num2str(size(handles.FileName,2)),')')}),' [GRAY]');
        end
        set(findobj('Tag','current_input_image_name_and_number'),'String',image_name);
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end