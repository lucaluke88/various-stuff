%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function similarity_menu_Callback(hObject, eventdata, handles)
    try
        if iscell(handles.output_image)
            s1 = size(handles.output_image,2);
        else
            s1 = 1;
        end
        
        if iscell(handles.TrainingFileName)
            s2 = size(handles.TrainingFileName,2);
        else
            s2 = 1;
        end
        
        n_iterazioni = min(s1,s2);
        
        if(iscell(handles.TrainingFileName))
            [~,~,type] = fileparts(strcat(handles.TrainingPathName,handles.TrainingFileName{1}));
            training_image = cell(size(handles.TrainingFileName,2));
            handles.score = cell(size(handles.TrainingFileName,2));
            for i=1:n_iterazioni
                if strcmp(type,'.dcm') % sono immagini DICOM
                    training_image{i} = dicomread(strcat(handles.TrainingPathName,handles.TrainingFileName{i}));
                else % sono immagini normali
                    training_image{i} = imread(strcat(handles.TrainingPathName,handles.TrainingFileName{i}));
                end
                handles.score{i} = compute_similarity(hObject, eventdata, handles,handles.output_image{i},training_image{i});
                display(handles.score{i});
            end
            
            axes(handles.similarity_axes);
            
            set(handles.similarity_axes,'Xlim', [0 size(handles.TrainingFileName,2)], 'YLim', [0 1]);
            bar((1:n_iterazioni),cell2mat(handles.score),'FaceColor','g'); % grafico
            title('Similarity score');
            xlabel('Image') % x-axis label
            ylabel('score') % y-axis label
            
        else
            [~,~,type] = fileparts(fullfile(handles.TrainingPathName,handles.TrainingFileName));
            if strcmp(type,'.dcm') % sono immagini DICOM
                training_image = dicomread(fullfile(handles.TrainingPathName,handles.TrainingFileName));
            else % sono immagini normali
                training_image = imread(fullfile(handles.TrainingPathName,handles.TrainingFileName));
            end
            if iscell(handles.output_image)
                handles.score = compute_similarity(hObject, eventdata, handles,handles.output_image{1},training_image);
            else
                handles.score = compute_similarity(hObject, eventdata, handles,handles.output_image,training_image);
            end
            set(findobj('Tag','score_text'),'String',strcat({'Similarity score:'},{' '},num2str(handles.score)));
            
        end
        
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end