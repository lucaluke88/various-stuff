%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function crop_image_Callback(hObject, eventdata, handles)
    axes(handles.input_image_axes);
    if iscell(handles.input_image)
        cropped = imcrop(handles.input_image{handles.input_image_cursor});
        handles.input_image{handles.input_image_cursor} = cropped;
    else
        cropped = imcrop(handles.input_image);
        handles.input_image = cropped;
    end
    imshow(cropped);
    guidata(hObject, handles);
end