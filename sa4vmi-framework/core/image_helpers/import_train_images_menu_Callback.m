%% SAV4MI framework - import training images callback
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function import_train_images_menu_Callback(hObject, eventdata, handles)
    try
        [handles.TrainingFileName,handles.TrainingPathName] = uigetfile({'*.dcm';'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the training image(s)','MultiSelect', 'on');
        % salvo per futuri utilizzi
        recent_training.TrainingFileName = handles.TrainingFileName;
        recent_training.TrainingPathName = handles.TrainingPathName; %#ok<*STRNU>
        save(fullfile('settings','recent_training'),'recent_training');
        
        if isfield(handles,'TrainingFileName')
            if isfield(handles,'output_image')
                set(findobj('Tag','similarity_menu'),'Enable','On');
            end
        end
        
        if iscell(handles.TrainingFileName)
            s2 = size(handles.TrainingFileName,2);
            msgbox(strcat(num2str(s2),' images imported successfully!'));
        else
            msgbox('1 image imported successfully!');
        end
        
        
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
