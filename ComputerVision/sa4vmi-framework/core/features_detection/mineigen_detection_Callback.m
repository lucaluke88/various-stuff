%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function mineigen_detection_Callback(hObject, eventdata, handles)
    try
        if iscell(handles.input_image)
            if is_rgb(handles.input_image{handles.input_image_cursor})
                errordlg('Works only on grayscale images!');
            else
                axes(handles.output_image_axes);
                imshow(handles.input_image{handles.input_image_cursor},[]);
                hold on;
                handles.corners = detectMinEigenFeatures(handles.input_image{handles.input_image_cursor});
                plot(handles.corners.selectStrongest(50));
            end
        else
            if is_rgb(handles.input_image)
                errordlg('Works only on grayscale images!');
            else
                axes(handles.output_image_axes);
                imshow(handles.input_image,[]);
                hold on;
                handles.corners = detectMinEigenFeatures(handles.input_image);
                plot(handles.corners.selectStrongest(50));
            end
        end
        
        
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end