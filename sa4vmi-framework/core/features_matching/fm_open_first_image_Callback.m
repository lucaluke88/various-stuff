function fm_open_first_image_Callback(hObject, eventdata, handles)
    try
        [handles.Matching_FileName1,handles.Matching_PathName1] = uigetfile({'*.dcm';'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the image(s)');
        set(findobj('Tag','hist_input_button'),'Enable','On');
        if handles.Matching_FileName1~=0
            [~,~,type] = fileparts(strcat(handles.Matching_PathName1,handles.Matching_FileName1));
            handles.input_image = zeros(1);
            
            if (strcmp(type,'.dcm')) % è dicom
                handles.input_image = dicomread(strcat(handles.Matching_PathName1,handles.Matching_FileName1));
                set(findobj('Tag','crop_image'),'Enable','Off');
            else % è un'immagine normale
                handles.input_image = imread(strcat(handles.Matching_PathName1,handles.Matching_FileName1));
                set(findobj('Tag','crop_image'),'Enable','On');
            end
            axes(handles.input_image_axes);
            imshow(handles.input_image, []);
            set(findobj('Tag','current_input_image_name_and_number'),'String',handles.Matching_FileName1);
            
            guidata(hObject,handles);
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end