% --------------------------------------------------------------------
function fast_import_workspace_Callback(hObject, eventdata, handles)
    try
        if exist(fullfile('settings','current_workspace.mat'), 'file') == 2
            
            load(fullfile('settings','current_workspace.mat'));
            
            %% caricamento parametri
            
            handles.M = state.M;
            handles.F = state.F;
            handles.metric_name = state.metric_name;
            handles.function_name = state.function_name;
            
            
            if isfield(state,'par2')
                handles.par2 = state.par2;
                set(findobj('Tag','edit_text_2'),'String',num2str(handles.par2));
                set(findobj('Tag','input_text_2'),'String',handles.F(2));
                if isfield(state,'par3')
                    handles.par3 = state.par3;
                    set(findobj('Tag','edit_text_3'),'String',num2str(handles.par3));
                    set(findobj('Tag','input_text_3'),'String',handles.F(3));
                    if isfield(state,'par4')
                        handles.par4 = state.par4;
                        set(findobj('Tag','edit_text_4'),'String',num2str(handles.par4));
                        set(findobj('Tag','input_text_4'),'String',handles.F(4));
                        if isfield(state,'par5')
                            handles.par5 = state.par5;
                            set(findobj('Tag','edit_text_5'),'String',num2str(handles.par5));
                            set(findobj('Tag','input_text_5'),'String',handles.F(5));
                            if isfield(state,'par6')
                                handles.par6 = state.par6;
                                set(findobj('Tag','edit_text_6'),'String',num2str(handles.par6));
                                set(findobj('Tag','input_text_6'),'String',handles.F(6));
                                if isfield(state,'par7')
                                    handles.par7 = state.par7;
                                    set(findobj('Tag','edit_text_7'),'String',num2str(handles.par7));
                                    set(findobj('Tag','input_text_7'),'String',handles.F(7));
                                    if isfield(state,'par8')
                                        handles.par8 = state.par8;
                                        set(findobj('Tag','edit_text_8'),'String',num2str(handles.par8));
                                        set(findobj('Tag','input_text_8'),'String',handles.F(8));
                                        if isfield(state,'par9')
                                            handles.par9 = state.par9;
                                            set(findobj('Tag','edit_text_9'),'String',num2str(handles.par9));
                                            set(findobj('Tag','input_text_9'),'String',handles.F(9));
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            %% parametri metrica
            
            if isfield(state,'metric_par_4')
                handles.metric_par_4 = state.metric_par_4;
                set(findobj('Tag','metric_edit_4'),'String',num2str(handles.metric_par_4));
                set(findobj('Tag','similarity_input_name_4'),'String',handles.M(3));
                if isfield(state,'metric_par_5')
                    handles.metric_par_5 = state.metric_par_5;
                    set(findobj('Tag','metric_edit_5'),'String',num2str(handles.metric_par_5));
                    set(findobj('Tag','similarity_input_name_5'),'String',handles.M(4));
                    if isfield(state,'metric_par_6')
                        handles.metric_par_6 = state.metric_par_6;
                        set(findobj('Tag','metric_edit_6'),'String',num2str(handles.metric_par_6));
                        set(findobj('Tag','similarity_input_name_6'),'String',handles.M(5));
                        if isfield(state,'metric_par_7')
                            handles.metric_par_7 = state.metric_par_7;
                            set(findobj('Tag','metric_edit_7'),'String',num2str(handles.metric_par_7));
                            set(findobj('Tag','similarity_input_name_7'),'String',handles.M(6));
                            if isfield(state,'metric_par_8')
                                handles.metric_par_8 = state.metric_par_8;
                                set(findobj('Tag','metric_edit_8'),'String',num2str(handles.metric_par_8));
                                set(findobj('Tag','similarity_input_name_8'),'String',handles.M(7));
                                if isfield(state,'metric_par_9')
                                    handles.metric_par_9 = state.metric_par_9;
                                    set(findobj('Tag','metric_edit_9'),'String',num2str(handles.metric_par_9));
                                    set(findobj('Tag','similarity_input_name_9'),'String',handles.M(8));
                                    if isfield(state,'metric_par_10')
                                        handles.metric_par_10 = state.metric_par_10;
                                        set(findobj('Tag','metric_edit_10'),'String',num2str(handles.metric_par_10));
                                        set(findobj('Tag','similarity_input_name_10'),'String',handles.M(9));
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
            %% input and output image, axes, buttons
            
            if isfield(state,'input_image')
                handles.input_image = state.input_image;
                if iscell(handles.input_image)
                    axes(handles.input_image_axes);
                    handles.input_image_cursor = state.input_image_cursor;
                    imshow(handles.input_image{handles.input_image_cursor}, []);
                else
                    axes(handles.input_image_axes);
                    imshow(handles.input_image, []);
                    set(findobj('Tag','current_input_image_name_and_number'),'String',handles.FileName);
                end
            end
            
            if isfield(state,'output_image')
                handles.output_image = state.output_image;
                if iscell(handles.output_image)
                    axes(handles.output_image_axes);
                    handles.output_image_cursor = state.output_image_cursor;
                    imshow(handles.output_image{handles.output_image_cursor}, []);
                    
                    handles.FileName = state.FileName;
                    set(findobj('Tag','current_output_image_name_and_number'),'String',strcat({handles.FileName{handles.output_image_cursor}},{' (output) '},{strcat('(',num2str(handles.output_image_cursor),'/',num2str(size(handles.FileName,2)),')')}));
                else
                    axes(handles.output_image_axes);
                    imshow(handles.output_image, []);
                    handles.FileName = state.FileName;
                    set(findobj('Tag','current_output_image_name_and_number'),'String','');
                end
            end
            
            
            
            
            %% training axes, images, menus
            
            if isfield(state,'TrainingFileName')
                handles.TrainingFileName = state.TrainingFileName;
                handles.TrainingPathName = state.TrainingPathName;
                
                
            end
            
            
            %% function and metrics popup and parameters
            
            set(handles.popup_functions,'String',getFunctionList(),'Value',state.function_entry_value);
            set(handles.popup_similarity,'String',getMetricList(),'Value',state.metric_entry_value);
            
            showHelp(hObject, eventdata, handles);
            showMetricHelp(hObject, eventdata, handles);
            
            %% performances axes
            if isfield(state,'execution_time')
                if isfield(state,'execution_number')
                    handles.execution_time = state.execution_time;
                    handles.execution_number = state.execution_number;
                    handles.time = state.time;
                    
                    set(findobj('Tag','elapsed_time'),'String',strcat({'Elapsed time (global) :'},{' '},num2str(handles.time)));
                    
                    axes(handles.global_performance_axes);
                    set(handles.global_performance_axes,'Xlim', [0 handles.execution_number], 'YLim', [0 max(handles.execution_time)],'XTickLabel',1:handles.execution_number);
                    bar((1:handles.execution_number),handles.execution_time,'FaceColor','b'); % grafico
                    
                    title('Global Performances');
                    xlabel('Execution') % x-axis label
                    ylabel('Time') % y-axis label
                    if iscell(handles.output_image)
                        set(findobj('Tag','performance_analyzer_axes'),'Visible','On');
                        % performances immagine per immagine
                        handles.single_time_array = state.single_time_array;
                        maximum = max(handles.single_time_array);
                        maximum = maximum(1);
                        
                        axes(handles.performance_analyzer_axes);
                        
                        set(handles.performance_analyzer_axes,'Xlim', [0 size(handles.output_image,2)], 'YLim', [0 maximum]);
                        bar((1:size(handles.output_image,2)),handles.single_time_array,'FaceColor','r'); % grafico
                        title('Image-By-Image Performances');
                        xlabel('Image') % x-axis label
                        ylabel('Time') % y-axis label
                    end
                end
            end
            
            similarity_menu_Callback(hObject, eventdata, handles);
            
            
            
            
            guidata(hObject,handles);
        else
            errordlg('savefile not found!');
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function showHelp(hObject, eventdata, handles)
    try
        [help_content,help_found] = parse_help(handles.function_name);
        if(help_found)
            set(findobj('Tag','uipanel15'),'Title','Help file content');
        else
            set(findobj('Tag','uipanel15'),'Title','Code (help file not found)');
        end
        set(findobj('Tag','info_box'),'String',help_content);
        
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function showMetricHelp(hObject, eventdata, handles)
    try
        [help_content,help_found] = parse_metric_help(handles.metric_name);
        if(help_found)
            set(findobj('Tag','uipanel17'),'Title','Help file content');
        else
            set(findobj('Tag','uipanel17'),'Title','Code (help file not found)');
        end
        set(findobj('Tag','info_metric_box'),'String',help_content);
        
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end