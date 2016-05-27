%% SAV4MI framework - Open Image(s) Callbacks
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function open_image_menu_Callback(hObject, eventdata, handles)
    try
        [handles.FileName,handles.PathName] = uigetfile({'*.dcm';'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the image(s)','MultiSelect', 'on');
        
        % output gui objects disabling (reset)
        set(findobj('Tag','previous_output_image_button'),'Enable','Off');
        set(findobj('Tag','next_output_image_button'),'Enable','Off');
        set(findobj('Tag','previous_compare_button'),'Enable','Off');
        set(findobj('Tag','next_compare_button'),'Enable','Off');
        set(findobj('Tag','hist_output_button'),'Enable','Off');
        
        % report objects disabling (reset)
        
        set(findobj('Tag','save_report_text'),'Enable','Off');
        set(findobj('Tag','save_report_as_mat'),'Enable','Off');
        
        % common input gui object enabling
        
        set(findobj('Tag','input_image_axes'),'Visible','On');
        set(findobj('Tag','import_last'),'Enable','On');
        set(findobj('Tag','hist_input_button'),'Enable','On');
        set(findobj('Tag','features_supermenu'),'Enable','On');
        
        %% multiple image loading
        if iscell(handles.FileName)
            
            [~,~,type] = fileparts(strcat(handles.PathName,handles.FileName{1}));
            handles.input_image = cell(size(handles.FileName,2));
            for i=1:size(handles.FileName,2)
                if strcmp(type,'.dcm') % sono immagini DICOM
                    handles.input_image{i} = dicomread(strcat(handles.PathName,handles.FileName{i}));
                    set(findobj('Tag','crop_image'),'Enable','Off');
                else % sono immagini normali
                    handles.input_image{i} = imread(strcat(handles.PathName,handles.FileName{i}));
                    set(findobj('Tag','crop_image'),'Enable','On');
                end
            end
            handles.input_image_cursor = 1;
            axes(handles.input_image_axes);
            imshow(handles.input_image{1}, []);
            
            set(findobj('Tag','previous_input_image_button'),'Enable','On');
            set(findobj('Tag','next_input_image_button'),'Enable','On');
            
            set(findobj('Tag','execute_single_menu'),'Enable','Off');
            set(findobj('Tag','execute_all_menu'),'Enable','On');
            set(findobj('Tag','color2gray_menu'),'Enable','On');
            set(findobj('Tag','color2grayall_menu'),'Enable','On');
            set(findobj('Tag','histeq_menu'),'Enable','On');
            set(findobj('Tag','histeqall_menu'),'Enable','On');
            
            
            
            % file name label with rgb/grayscale info
            if is_rgb(handles.input_image)
                image_name = strcat(strcat({handles.FileName{1}},{'  '},{strcat('(1/',num2str(size(handles.FileName,2)),')')}),' [RGB]'); %#ok<*CCAT1>
            else
                image_name = strcat(strcat({handles.FileName{1}},{'  '},{strcat('(1/',num2str(size(handles.FileName,2)),')')}),' [GRAY]');
            end
            
            set(findobj('Tag','current_input_image_name_and_number'),'String',image_name);
            
            
            %% single image loading
        else if handles.FileName~=0
                
                [~,~,type] = fileparts(strcat(handles.PathName,handles.FileName));
                handles.input_image = zeros(1);
                
                if (strcmp(type,'.dcm'))
                    handles.input_image = dicomread(strcat(handles.PathName,handles.FileName));
                    set(findobj('Tag','crop_image'),'Enable','Off');
                else
                    handles.input_image = imread(strcat(handles.PathName,handles.FileName));
                    set(findobj('Tag','crop_image'),'Enable','On');
                end
                
                axes(handles.input_image_axes);
                imshow(handles.input_image, []);
                
                % file name label with rgb/grayscale info
                
                if is_rgb(handles.input_image)
                    image_name = strcat(handles.FileName,' [RGB]');
                else
                    image_name = strcat(handles.FileName,' [GRAY]');
                end
                set(findobj('Tag','current_input_image_name_and_number'),'String',image_name);
                
                % enabling single image options
                
                set(findobj('Tag','current_input_image_name_and_number'),'String',image_name);
                set(findobj('Tag','execute_single_menu'),'Enable','On');
                set(findobj('Tag','color2gray_menu'),'Enable','On');
                
                % disabling multiple images options
                set(findobj('Tag','execute_all_menu'),'Enable','Off');
                set(findobj('Tag','previous_input_image_button'),'Enable','Off');
                set(findobj('Tag','next_input_image_button'),'Enable','Off');
                set(findobj('Tag','color2grayall_menu'),'Enable','Off');
                set(findobj('Tag','histeqall_menu'),'Enable','Off');
                
                
            end
        end
        
        % reset stats
        
        handles.execution_time = zeros(0);
        handles.execution_number = 0;
        
        % export history data
        
        recent.FileName = handles.FileName;
        recent.PathName = handles.PathName; %#ok<*STRNU>
        save(fullfile('settings','recent'),'recent');
        
        % saving gui data
        guidata(hObject,handles);
        
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end