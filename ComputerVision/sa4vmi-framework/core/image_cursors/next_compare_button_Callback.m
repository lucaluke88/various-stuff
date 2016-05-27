%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework


function next_compare_button_Callback(hObject, eventdata, handles)
    try
        if(handles.input_image_cursor==size(handles.FileName,2))
            handles.input_image_cursor = 1;
        else
            handles.input_image_cursor = handles.input_image_cursor + 1;
        end
        handles.output_image_cursor = handles.input_image_cursor;
        
        axes(handles.input_image_axes);
        imshow(handles.input_image{handles.input_image_cursor}, []);
        if is_rgb(handles.input_image) == 1
            image_name = strcat(strcat({handles.FileName{1}},{'  '},{strcat('(',num2str(handles.input_image_cursor),'/',num2str(size(handles.FileName,2)),')')}),' [RGB]');
        else
            image_name = strcat(strcat({handles.FileName{1}},{'  '},{strcat('(',num2str(handles.input_image_cursor),'/',num2str(size(handles.FileName,2)),')')}),' [GRAY]');
        end
        set(findobj('Tag','current_input_image_name_and_number'),'String',image_name);
        axes(handles.output_image_axes);
        imshow(handles.output_image{handles.output_image_cursor}, []);
        set(findobj('Tag','current_output_image_name_and_number'),'String',strcat({handles.FileName{handles.output_image_cursor}},{' (output) '},{strcat('(',num2str(handles.output_image_cursor),'/',num2str(size(handles.FileName,2)),')')}));
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end