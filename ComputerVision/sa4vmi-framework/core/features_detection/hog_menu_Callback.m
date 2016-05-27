%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function hog_menu_Callback(hObject, eventdata, handles)
    try
        if iscell(handles.input_image)
            axes(handles.output_image_axes);
            imshow(handles.input_image{handles.input_image_cursor},[]);
            hold on;
            [handles.features, handles.hogVisualization] = extractHOGFeatures(handles.input_image{handles.input_image_cursor});
            plot(handles.hogVisualization);
        else
            axes(handles.output_image_axes);
            imshow(handles.input_image,[]);
            hold on;
            [handles.features, handles.hogVisualization] = extractHOGFeatures(handles.input_image);
            plot(handles.hogVisualization);
        end
        
       
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end