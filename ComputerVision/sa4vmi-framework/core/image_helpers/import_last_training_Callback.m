function import_last_training_Callback(hObject, eventdata, handles)
    try
        load(fullfile('settings','recent_training'),'recent_training');
        handles.TrainingFileName = recent_training.TrainingFileName;
        handles.TrainingPathName = recent_training.TrainingPathName;
        clear recent_training;
        
        if isfield(handles,'TrainingFileName')
            if isfield(handles,'output_image')
                set(findobj('Tag','similarity_menu'),'Enable','On');
            end
        end
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end