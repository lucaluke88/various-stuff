%% SAV4MI framework - Import last image(s) Callback
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function import_last_Callback(hObject, eventdata, handles)
    try
        % load from recent.mat file
        
        load(fullfile('settings','recent'),'recent');
        
        handles.FileName = recent.FileName;
        handles.PathName = recent.PathName;
        
        
        
        %% multiple image loading
        if iscell(handles.FileName)
            
            [~,~,type] = fileparts(strcat(handles.PathName,handles.FileName{1}));
            handles.input_image = cell(size(handles.FileName,2));
            for i=1:size(handles.FileName,2)
                if strcmp(type,'.dcm') % sono immagini DICOM
                    handles.input_image{i} = dicomread(strcat(handles.PathName,handles.FileName{i}));
                    
                else % sono immagini normali
                    handles.input_image{i} = imread(strcat(handles.PathName,handles.FileName{i}));
                    
                end
            end
            handles.input_image_cursor = 1;
            axes(handles.input_image_axes);
            imshow(handles.input_image{1}, []);
            
            
            
            
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
                    
                else
                    handles.input_image = imread(strcat(handles.PathName,handles.FileName));
                    
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
                
                
                
            end
        end
        
        % reset stats
        
        handles.execution_time = zeros(0);
        handles.execution_number = 0;
        
        % saving gui data
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end