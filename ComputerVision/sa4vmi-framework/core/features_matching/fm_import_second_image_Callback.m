function fm_import_second_image_Callback(hObject, eventdata, handles)
    try
        [handles.Matching_FileName2,handles.Matching_PathName2] = uigetfile({'*.dcm';'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the image(s)');
        set(findobj('Tag','hist_input_button'),'Enable','On');
        if handles.Matching_FileName2~=0
            [~,~,type] = fileparts(strcat(handles.Matching_PathName2,handles.Matching_FileName2));
            handles.output_image = zeros(1);
            if (strcmp(type,'.dcm')) % è dicom
                handles.output_image = dicomread(strcat(handles.Matching_PathName2,handles.Matching_FileName2));
                set(findobj('Tag','crop_image'),'Enable','Off');
            else % è un'immagine normale
                handles.output_image = imread(strcat(handles.Matching_PathName2,handles.Matching_FileName2));
            end
            axes(handles.output_image_axes);
            imshow(handles.output_image, []);
            
            set(findobj('Tag','current_output_image_name_and_number'),'String',handles.Matching_FileName2);
            
            guidata(hObject,handles);
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end