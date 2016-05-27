%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function color2grayall_menu_Callback(hObject, eventdata, handles)
    try
        for i=1:size(handles.FileName,2)
            if is_rgb(handles.input_image{i})==1
                handles.input_image{i} = rgb2gray(handles.input_image{i});
            end
        end
        axes(handles.input_image_axes);
        imshow(handles.input_image{handles.input_image_cursor}, []);
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end