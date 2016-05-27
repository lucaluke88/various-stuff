%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
% --------------------------------------------------------------------
function execute_single_menu_Callback(hObject, eventdata, handles)
    
    try
        tic;
        
        % get function handle
        invoked_function = getFunctionHandleFromFile(fullfile('functions',handles.function_name));
        
        switch(nargin(invoked_function)) % number of parameters needed
            case 1
                handles.output_image = invoked_function(handles.input_image);
            case 2
                handles.output_image = invoked_function(handles.input_image,handles.par2);
            case 3
                handles.output_image = invoked_function(handles.input_image,handles.par2,handles.par3);
            case 4
                handles.output_image = invoked_function(handles.input_image,handles.par2,handles.par3,handles.par4);
            case 5
                handles.output_image = invoked_function(handles.input_image,handles.par2,handles.par3,handles.par4,handles.par5);
            case 6
                handles.output_image = invoked_function(handles.input_image,handles.par2,handles.par3,handles.par4,handles.par5,handles.par6);
            case 7
                handles.output_image = invoked_function(handles.input_image,handles.par2,handles.par3,handles.par4,handles.par5,handles.par6,handles.par7);
            case 8
                handles.output_image = invoked_function(handles.input_image,handles.par2,handles.par3,handles.par4,handles.par5,handles.par6,handles.par7,handles.par8);
            case 9
                handles.output_image = invoked_function(handles.input_image,handles.par2,handles.par3,handles.par4,handles.par5,handles.par6,handles.par7,handles.par8,handles.par9);
        end
        
        % print the output image
        
        axes(handles.output_image_axes);
        imshow(handles.output_image, []);
        
        
        % Performance estimation
        
        handles.time = toc;
        
        set(findobj('Tag','elapsed_time'),'String',strcat('Elapsed time (seconds):',num2str(handles.time)));
        
        handles.execution_number = handles.execution_number + 1;
        handles.execution_time(handles.execution_number) = handles.time;
        
        % global performances
        
        axes(handles.global_performance_axes);
        set(handles.global_performance_axes,'Xlim', [0 handles.execution_number], 'YLim', [0 max(handles.execution_time)],'XTickLabel',1:handles.execution_number);
        bar((1:handles.execution_number),handles.execution_time,'FaceColor','b'); % grafico
        title('Performances');
        xlabel('Execution') % x-axis label
        ylabel('Time') % y-axis label
        
        % disabling the image-for-image performance analysis
        set(findobj('Tag','performance_analyzer_axes'),'Visible','Off');
        
        % if you previously have loaded the training set, the similarity menu object
        % will be enabled
        
        if isfield(handles,'TrainingFileName')
            if isfield(handles,'output_image')
                set(findobj('Tag','similarity_menu'),'Enable','On');
            end
        end
        
        % enabling the save image menu item
        
        set(findobj('Tag','save_images_menu'),'Enable','On');
        set(findobj('Tag','save_all_images_menu'),'Enable','Off'); % because is a single image
        
        % enabling output histogram option
        set(findobj('Tag','hist_output_button'),'Enable','On');
        
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end


