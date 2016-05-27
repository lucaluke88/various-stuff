%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function save_report_text_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.txt', 'Save As');
        fileID = fopen(fullfile(PathName,FileName), 'wt' );
        
        if iscell(handles.TrainingFileName)
            size_tr =size(handles.TrainingFileName,2);
        else
            size_tr = 1;
        end
        if iscell(handles.FileName)
            size_in =size(handles.FileName,2);
        else
            size_in = 1;
        end
        my_size = min(size_tr,size_in);
        
        if my_size >1
            fwrite(fileID,'Training images:');
            for i=1:my_size
                fwrite(fileID,strcat(handles.TrainingFileName{i},';'));
            end
            fwrite(fileID,sprintf('\n'));
            
            fwrite(fileID,'Input images:');
            for i=1:my_size
                fwrite(fileID,strcat(handles.FileName{i},';'));
            end
            fwrite(fileID,sprintf('\n'));
        else
            fwrite(fileID,strcat('Training image:','  "',handles.TrainingFileName,'";'));
            fwrite(fileID,sprintf('\n'));
            fwrite(fileID,strcat('Input image:',' "',handles.FileName,'";'));
            fwrite(fileID,sprintf('\n'));
        end
        
        fwrite(fileID,'*****************************');
        fwrite(fileID,sprintf('\n'));
        
        fwrite(fileID,strcat('Function Name:','  "',handles.function_name,'";'));
        fwrite(fileID,sprintf('\n'));
        
        
        if isfield(handles,'par2')
            fwrite(fileID,strcat('Function Parameter 2:',' "',num2str(handles.par2),'";'));
            fwrite(fileID,sprintf('\n'));
            if isfield(handles,'par3')
                fwrite(fileID,strcat('Function Parameter 3:',' "',num2str(handles.par3),'";'));
                fwrite(fileID,sprintf('\n'));
                if isfield(handles,'par4')
                    fwrite(fileID,strcat('Function Parameter 4:',' "',num2str(handles.par4),'";'));
                    fwrite(fileID,sprintf('\n'));
                    if isfield(handles,'par5')
                        fwrite(fileID,strcat('Function Parameter 5:',' "',num2str(handles.par5),'";'));
                        fwrite(fileID,sprintf('\n'));
                        if isfield(handles,'par6')
                            fwrite(fileID,strcat('Function Parameter 6:',' "',num2str(handles.par6),'";'));
                            fwrite(fileID,sprintf('\n'));
                            if isfield(handles,'par7')
                                fwrite(fileID,strcat('Function Parameter 7:',' "',num2str(handles.par7),'";'));
                                fwrite(fileID,sprintf('\n'));
                                if isfield(handles,'par8')
                                    fwrite(fileID,strcat('Function Parameter 8:',' "',num2str(handles.par8),'";'));
                                    fwrite(fileID,sprintf('\n'));
                                    if isfield(handles,'par9')
                                        fwrite(fileID,strcat('Function Parameter 9:',' "',num2str(handles.par9),'";'));
                                        fwrite(fileID,sprintf('\n'));
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        fwrite(fileID,'*****************************');
        fwrite(fileID,sprintf('\n'));
        
        fwrite(fileID,strcat('Metric Name:',' "',handles.metric_name,'";'));
        fwrite(fileID,sprintf('\n'));
        
        if isfield(handles,'metric_par_4')
            fwrite(fileID,strcat('Metric Parameter 3:',' "',num2str(handles.metric_par_4),'";'));
            fwrite(fileID,sprintf('\n'));
            if isfield(handles,'metric_par_5')
                fwrite(fileID,strcat('Metric Parameter 4:',' "',num2str(handles.metric_par_5),'";'));
                fwrite(fileID,sprintf('\n'));
                if isfield(handles,'metric_par_6')
                    fwrite(fileID,strcat('Metric Parameter 5:',' "',num2str(handles.metric_par_6),'";'));
                    fwrite(fileID,sprintf('\n'));
                    if isfield(handles,'metric_par_7')
                        fwrite(fileID,strcat('Metric Parameter 7:',' "',num2str(handles.metric_par_7),'";'));
                        fwrite(fileID,sprintf('\n'));
                        if isfield(handles,'metric_par_8')
                            fwrite(fileID,strcat('Metric Parameter 8:',' "',num2str(handles.metric_par_8),'";'));
                            fwrite(fileID,sprintf('\n'));
                            if isfield(handles,'metric_par_9')
                                fwrite(fileID,strcat('Metric Parameter 9:',' "',num2str(handles.metric_par_9),'";'));
                                fwrite(fileID,sprintf('\n'));
                                if isfield(handles,'metric_par_10')
                                    fwrite(fileID,strcat('Metric Parameter 10:',' "',num2str(handles.metric_par_10),'";'));
                                    fwrite(fileID,sprintf('\n'));
                                end
                            end
                        end
                    end
                end
            end
        end
        fwrite(fileID,'*****************************');
        fwrite(fileID,sprintf('\n'));
        
        if iscell(handles.score)
            fwrite(fileID,'Scores:');
            for i=1:my_size
                fwrite(fileID,strcat(num2str(handles.score{i}),';'));
            end
            fwrite(fileID,sprintf('\n'));
        else
            fwrite(fileID,strcat('Score:','  ',num2str(handles.score),';'));
            fwrite(fileID,sprintf('\n'));
        end
        fwrite(fileID,'*****************************');
        fwrite(fileID,sprintf('\n'));
        fwrite(fileID,'	Courtesy of SAV4MI ');
        fwrite(fileID,sprintf('\n'));
        fwrite(fileID,'*****************************');
        fwrite(fileID,sprintf('\n'));
        fclose(fileID);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end