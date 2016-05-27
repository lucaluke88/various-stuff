%% SAV4MI framework - Corner export callback
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function corner_extraction_Callback(hObject, eventdata, handles)
    try
        if iscell(handles.input_image)
            if is_rgb(handles.input_image{handles.input_image_cursor})
                errordlg('Works only on grayscale images!');
            else
                axes(handles.output_image_axes);
                imshow(handles.input_image{handles.input_image_cursor},[]);
                hold on;
                corners = detectHarrisFeatures(handles.input_image{handles.input_image_cursor});
                [handles.features, handles.valid_corners] = extractFeatures(handles.input_image{handles.input_image_cursor}, corners);
                plot(handles.valid_corners);
            end
        else
            if is_rgb(handles.input_image)
                errordlg('Works only on grayscale images!');
            else
                axes(handles.output_image_axes);
                imshow(handles.input_image,[]);
                hold on;
                corners = detectHarrisFeatures(handles.input_image);
                [handles.features, handles.valid_corners] = extractFeatures(handles.input_image, corners);
                plot(handles.valid_corners);
            end
            
        end
        
       
        
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
