%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework


function histeq_menu_Callback(hObject, eventdata, handles)
    try
        if iscell(handles.input_image)
            if is_rgb(handles.input_image{handles.input_image_cursor})==0
                handles.input_image{handles.input_image_cursor} = histeq(handles.input_image{handles.input_image_cursor});
                axes(handles.input_image_axes);
                imshow(handles.input_image{handles.input_image_cursor}, []);
            end
        else
            if is_rgb(handles.input_image)==0
                handles.input_image = histeq(handles.input_image);
                axes(handles.input_image_axes);
                imshow(handles.input_image, []);
            end
        end
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end