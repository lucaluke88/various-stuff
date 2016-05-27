%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function next_output_image_button_Callback(hObject, eventdata, handles)
    try
        if(handles.output_image_cursor==size(handles.FileName,2))
            handles.output_image_cursor = 1;
        else
            handles.output_image_cursor = handles.output_image_cursor + 1;
        end
        axes(handles.output_image_axes);
        imshow(handles.output_image{handles.output_image_cursor}, []);
        set(findobj('Tag','current_output_image_name_and_number'),'String',strcat({handles.FileName{handles.output_image_cursor}},{' (output) '},{strcat('(',num2str(handles.output_image_cursor),'/',num2str(size(handles.FileName,2)),')')}));
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end