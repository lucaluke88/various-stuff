function execute_matching_Callback(hObject, eventdata, handles)
    
    try
        if is_rgb(handles.input_image) == 1
            I1 = rgb2gray(handles.input_image);
        else
            I1 = handles.input_image;
        end
        
        if is_rgb(handles.output_image) == 1
            I2 = rgb2gray(handles.output_image);
        else
            I2 = handles.output_image;
        end
        %     SURF features.
        points1 = detectSURFFeatures(I1);
        points2 = detectSURFFeatures(I2);
        %     Extract features.
        [f1, vpts1] = extractFeatures(I1, points1);
        [f2, vpts2] = extractFeatures(I2, points2);
        %     Match features.
        index_pairs = matchFeatures(f1, f2) ;
        matched_pts1 = vpts1(index_pairs(:, 1));
        matched_pts2 = vpts2(index_pairs(:, 2));
        set(findobj('Tag','score_text'),'String','Matching result');
        %     Visualize putative matches.
        axes(handles.similarity_axes);
        showMatchedFeatures(I1,I2,matched_pts1,matched_pts2,'montage');
        title('Putative point matches');
        legend('matchedPts1','matchedPts2');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end