function mser_detection_Callback(hObject, eventdata, handles)
    try
        axes(handles.output_image_axes);
        imshow(handles.input_image, []);
    if iscell(handles.input_image)
        if is_rgb(handles.input_image{handles.input_image_cursor})
            errordlg('Works only on grayscale images!');
        else
            % metti features al posto di ~ per poter giocare
            handles.regions = detectMSERFeatures(handles.input_image{handles.input_image_cursor});
            axes(handles.output_image_axes);
            imshow(handles.input_image{handles.input_image_cursor},[]);
            hold on;
            plot(handles.regions, 'showPixelList', true, 'showEllipses', false);
            hold on;
            plot(handles.regions); % by default, plot displays ellipses and centroids
        end
    else
        if is_rgb(handles.input_image)
            errordlg('Works only on grayscale images!');
        else
            % metti features al posto di ~ per poter giocare
            handles.regions = detectMSERFeatures(handles.input_image);
            axes(handles.output_image_axes);
            imshow(handles.input_image,[]);
            hold on; 
            plot(handles.regions, 'showPixelList', true, 'showEllipses', false);
            hold on;
            plot(handles.regions); % by default, plot displays ellipses and centroids
        end
        
    end
    
    
    
    guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

