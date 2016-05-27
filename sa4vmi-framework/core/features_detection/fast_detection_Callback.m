
%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function fast_detection_Callback(hObject, eventdata, handles)
    try
        if iscell(handles.input_image)
            if is_rgb(handles.input_image{handles.input_image_cursor})
                errordlg('Works only on grayscale images!');
            else
                % metti features al posto di ~ per poter giocare
                axes(handles.output_image_axes);
                imshow(handles.input_image{handles.input_image_cursor});
                hold on;
                handles.corners = detectFASTFeatures(handles.input_image{handles.input_image_cursor});
                fastpoints = handles.corners.selectStrongest(50);
                plot(fastpoints);
            end
        else
            if is_rgb(handles.input_image)
                errordlg('Works only on grayscale images!');
            else
                % metti features al posto di ~ per poter giocare
                axes(handles.output_image_axes);
                imshow(handles.output_image_axes);
                hold on;
                handles.corners = detectFASTFeatures(handles.input_image);
                fastpoints = handles.corners.selectStrongest(50);
                plot(fastpoints);
            end
        end
        
       
        
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end