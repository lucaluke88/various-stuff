function inizialize_workspace(hObject, eventdata, handles)
    try
        %%  reset performance and execution statistics
        
        clear handles.execution_time;
        handles.execution_number = 0;
        set(findobj('Tag','elapsed_time'),'String',strcat('Elapsed time (seconds):',''));
        cla(handles.global_performance_axes);
        
        cla(handles.performance_analyzer_axes);
        
        
        %% reset function popup and parameters
        
        set(handles.popup_functions,'String',getFunctionList(),'Value',1);
        handles.function_name = change_popup_function(hObject, eventdata, handles);
        
        clear handles.par_2;
        clear handles.par_3;
        clear handles.par_4;
        clear handles.par_5;
        clear handles.par_6;
        clear handles.par_7;
        clear handles.par_8;
        clear handles.par_9;
        
        for j = 2 : 9
            set(findobj('Tag',strcat('input_text_',num2str(j))),'String',strcat('input_text_',num2str(j))) % cambio il nome dell'input box leggendo dalla funzione
            set(findobj('Tag',strcat('edit_text_',num2str(j))),'String','');
            
        end
        
        %% reset similarity popup, parameters and statistics
        
        set(handles.popup_similarity,'String',getMetricList(),'Value',1);
        handles.metric_name = change_popup_metric(hObject, eventdata, handles);
        
        cla(handles.similarity_axes);
        
        
        clear handles.metric_par_4;
        clear handles.metric_par_5;
        clear handles.metric_par_6;
        clear handles.metric_par_7;
        clear handles.metric_par_8;
        clear handles.metric_par_9;
        clear handles.metric_par_10;
        
        for j=4:10
            set(findobj('Tag',strcat('similarity_input_name_',num2str(j))),'String',strcat('input_text_',num2str(j))) % cambio il nome dell'input box leggendo dalla funzione
            set(findobj('Tag',strcat('metric_edit_',num2str(j))),'String','');
        end
        
        
        %%  history loading
        
        
        
        
        
        %% reset input content
        
        clear handles.input_image;
        clear handles.PathName;
        clear handles.FileName;
        clear handles.input_image_cursor;
        cla(handles.input_image_axes);
       
        
        
        %% reset output content
        
        clear handles.output_image;
        clear handles.output_image_cursor;
        set(findobj('Tag','current_output_image_name_and_number'),'String','');
       
        
       
        %% reset training content
        clear handles.TrainingPathName;
        clear handles.TrainingFileName;
        
        %% helpers loading
        
        showHelp(hObject, eventdata, handles);
        showMetricHelp(hObject, eventdata, handles);
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end