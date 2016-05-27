%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function execute_all_menu_Callback(hObject, eventdata, handles)
    try
        global_time = tic; % global time needed (from first image to last)
        
        % array of image-for-image time needed for applying the function
        handles.single_time_array = zeros(size(handles.FileName,2));
        
        % retrieve the function and obtain its handle
        invoked_function = getFunctionHandleFromFile(fullfile('functions',handles.function_name));
        
        % output images list inizialization
        handles.output_image = cell(size(handles.FileName,2));
        
        for i=1:size(handles.FileName,2)
            
            single_time = tic; % single image time counter
            
            switch(nargin(invoked_function)) % number of parameters needed
                case 1
                    handles.output_image{i} = invoked_function(handles.input_image{i});
                case 2
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2);
                case 3
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2,handles.par3);
                case 4
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2,handles.par3,handles.par4);
                case 5
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2,handles.par3,handles.par4,handles.par5);
                case 6
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2,handles.par3,handles.par4,handles.par5,handles.par6);
                case 7
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2,handles.par3,handles.par4,handles.par5,handles.par6,handles.par7);
                case 8
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2,handles.par3,handles.par4,handles.par5,handles.par6,handles.par7,handles.par8);
                case 9
                    handles.output_image{i} = invoked_function(handles.input_image{i},handles.par2,handles.par3,handles.par4,handles.par5,handles.par6,handles.par7,handles.par8,handles.par9);
            end
            handles.single_time_array(i) = toc(single_time);
        end
        
        handles.time = toc(global_time);
        
        axes(handles.output_image_axes);
        imshow(handles.output_image{1}, []);
        
        handles.output_image_cursor = 1; % set the cursor to the first image
        
        % enabling the multiple image cursor buttons
        set(findobj('Tag','previous_output_image_button'),'Enable','On');
        set(findobj('Tag','next_output_image_button'),'Enable','On');
        set(findobj('Tag','previous_compare_button'),'Enable','On');
        set(findobj('Tag','next_compare_button'),'Enable','On');
        
        % set the current image label
        set(findobj('Tag','current_output_image_name_and_number'),'String',strcat({handles.FileName{handles.output_image_cursor}},{' (output) '},{strcat('(',num2str(handles.output_image_cursor),'/',num2str(size(handles.FileName,2)),')')}));
        
        
        %% Performances stats
        
        set(findobj('Tag','elapsed_time'),'String',strcat({'Elapsed time (global) :'},{' '},num2str(handles.time)));
        
        handles.execution_number = handles.execution_number + 1;
        handles.execution_time(handles.execution_number) = handles.time;
        
        axes(handles.global_performance_axes);
        set(handles.global_performance_axes,'Xlim', [0 handles.execution_number], 'YLim', [0 max(handles.execution_time)],'XTickLabel',1:handles.execution_number);
        bar((1:handles.execution_number),handles.execution_time,'FaceColor','b'); % grafico
        
        title('Global Performances');
        xlabel('Execution') % x-axis label
        ylabel('Time') % y-axis label
        
        set(findobj('Tag','performance_analyzer_axes'),'Visible','On');
        
        % performances immagine per immagine
        maximum = max(handles.single_time_array);
        maximum = maximum(1);
        
        axes(handles.performance_analyzer_axes);
        
        set(handles.performance_analyzer_axes,'Xlim', [0 size(handles.output_image,2)], 'YLim', [0 maximum]);
        bar((1:size(handles.output_image,2)),handles.single_time_array,'FaceColor','r'); % grafico
        title('Image-By-Image Performances');
        xlabel('Image') % x-axis label
        ylabel('Time') % y-axis label
        
        if isfield(handles,'TrainingFileName')
            if isfield(handles,'output_image')
                set(findobj('Tag','similarity_menu'),'Enable','On');
            end
        end
        
        % enabling the save image(s) option
        set(findobj('Tag','save_images_menu'),'Enable','On');
        set(findobj('Tag','save_all_images_menu'),'Enable','On');
        set(findobj('Tag','hist_output_button'),'Enable','On');
        % save gui data
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
