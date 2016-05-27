%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function save_report_as_mat_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
        my_size = min(size(handles.TrainingFileName,2),size(handles.FileName,2));
        state.TrainingImage = handles.TrainingFileName(1:my_size);
        state.InputImage = handles.FileName(1:my_size);
        state.Function = handles.function_name;
        state.Metric = handles.metric_name;
        if isfield(handles,'par_2')
            state.function_parameters(1) = handles.par_2;
            if isfield(handles,'par_3')
                state.function_parameters(2) = handles.par_3;
                if isfield(handles,'par_4')
                    state.function_parameters(3) = handles.par_4;
                    if isfield(handles,'par_5')
                        state.function_parameters(4) = handles.par_5;
                        if isfield(handles,'par_6')
                            state.function_parameters(5) = handles.par_6;
                            if isfield(handles,'par_7')
                                state.function_parameters(6) = handles.par_7;
                                if isfield(handles,'par_8')
                                    state.function_parameters(7) = handles.par_8;
                                    if isfield(handles,'par_9')
                                        state.function_parameters(6) = handles.par_9;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        if isfield(handles,'metric_par_4')
            state.function_parameters(1) = handles.metric_par_4;
            if isfield(handles,'metric_par_5')
                state.function_parameters(2) = handles.metric_par_5;
                if isfield(handles,'metric_par_6')
                    state.function_parameters(3) = handles.metric_par_6;
                    if isfield(handles,'metric_par_7')
                        state.function_parameters(4) = handles.metric_par_7;
                        if isfield(handles,'metric_par_8')
                            state.function_parameters(5) = handles.metric_par_8;
                            if isfield(handles,'metric_par_9')
                                state.function_parameters(6) = handles.metric_par_9;
                                if isfield(handles,'metric_par_10')
                                    state.function_parameters(7) = handles.metric_par_10;
                                end
                            end
                        end
                    end
                end
            end
        end
        
        state.score = handles.score;
        
        save(fullfile(PathName,FileName),'state');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end