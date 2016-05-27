%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
% --------------------------------------------------------------------
function save_images_menu_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,FilterIndex] = uiputfile({'*.jpg';'*.gif';'*.png';'*.bmp';'*.tiff';'*.dcm'}, 'Save As');
        Name = fullfile(PathName, FileName);
        if(isfield( handles, 'output_image_cursor'))
            X = uint8(255*mat2gray(handles.output_image{handles.output_image_cursor}));
        else
            X = uint8(255*mat2gray(handles.output_image));
        end
        
        switch(FilterIndex)
            case 1
                imwrite(X, Name, 'jpg');
            case 2
                imwrite(X, Name, 'gif');
            case 3
                imwrite(X, Name, 'png');
            case 4
                imwrite(X, Name, 'bmp');
            case 5
                imwrite(X, Name, 'tiff');
            case 6
                dicomwrite(X,Name);
                
        end
        msgbox('Saved!');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end