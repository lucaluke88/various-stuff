function varargout = gui(varargin)
    % GUI MATLAB code for gui.fig
    %      GUI, by itself, creates a new GUI or raises the existing
    %      singleton*.
    %
    %      H = GUI returns the handle to a new GUI or the handle to
    %      the existing singleton*.
    %
    %      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in GUI.M with the given input arguments.
    %
    %      GUI('Property','Value',...) creates a new GUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before gui_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to gui_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES
    
    % Edit the above text to modify the response to help gui
    
    % Last Modified by GUIDE v2.5 11-Nov-2014 17:05:22
    
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
        'gui_Singleton',  gui_Singleton, ...
        'gui_OpeningFcn', @gui_OpeningFcn, ...
        'gui_OutputFcn',  @gui_OutputFcn, ...
        'gui_LayoutFcn',  [] , ...
        'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end
    
    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT
end

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to gui (see VARARGIN)
    
    % Choose default command line output for gui
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    
    % UIWAIT makes gui wait for user response (see UIRESUME)
    % uiwait(handles.method);
end

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the red source');
    handles.red_source = imread(strcat(PathName,FileName));
    if isrgb(handles.red_source) handles.red_source = rgb2gray(handles.red_source);
    end
    set(handles.red_axes,'Visible','On');
    axes(handles.red_axes);
    imshow(handles.red_source, []);
    guidata(hObject,handles);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the green source');
    handles.green_source = imread(strcat(PathName,FileName));
    if isrgb(handles.green_source) handles.green_source = rgb2gray(handles.green_source);
    end
    set(handles.green_axes,'Visible','On');
    axes(handles.green_axes);
    imshow(handles.green_source, []);
    guidata(hObject,handles);
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton3 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the blue source');
    handles.blue_source = imread(strcat(PathName,FileName));
    if isrgb(handles.blue_source) handles.blue_source = rgb2gray(handles.blue_source);
    end
    set(handles.blue_axes,'Visible','On');
    axes(handles.blue_axes);
    imshow(handles.blue_source, []);
    guidata(hObject,handles);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    switch get(handles.popupmenu1,'Value')
        case 1 %sovrapposizione semplice
            handles.output_image(:,:,1) = handles.red_source;
            handles.output_image(:,:,2) = handles.green_source;
            handles.output_image(:,:,3) = handles.blue_source;
        case 2 % con finestra
            [patch,rect_patch] = imcrop(handles.blue_source); % selezione manuale
            c = normxcorr2(patch,handles.red_source);
            [ypeak, xpeak] = find(c==max(c(:)));
            yoffSet = ypeak-size(patch,1);
            xoffSet = xpeak-size(patch,2);
            shift_x = uint8(rect_patch(1)-xoffSet);
            shift_y = uint8(rect_patch(2)-yoffSet);
            handles.red_source = circshift(handles.red_source,[shift_y shift_x]);
            c = normxcorr2(patch,handles.green_source);
            [ypeak, xpeak] = find(c==max(c(:)));
            yoffSet = ypeak-size(patch,1);
            xoffSet = xpeak-size(patch,2);
            shift_x = uint8(rect_patch(1)-xoffSet);
            shift_y = uint8(rect_patch(2)-yoffSet);
            handles.green_source = circshift(handles.green_source,[shift_y shift_x]);
            handles.output_image = cat(3,handles.red_source,handles.green_source,handles.blue_source);
        case 3
            ssd_minimo = 0;
            finestra = 10;
            for shift_riga = -finestra:finestra
                for shift_colonna = -finestra:finestra
                    immagine_shiftata = circshift(single(handles.red_source), [shift_riga, shift_colonna]);
                    ssd_tmp = sum(sum((uint8(immagine_shiftata) - handles.blue_source).^2));
                    if ssd_minimo == 0 % direttamente posso sostituire il valore
                        ssd_minimo = ssd_tmp;
                        R_spostato = immagine_shiftata;
                        shift_riga_rossa_stringa = num2str(shift_riga); %#ok<*NASGU>
                        shift_colonna_rossa_stringa = num2str(shift_colonna);
                    else if ssd_tmp < ssd_minimo % aggiorno l'SSD
                            ssd_minimo = ssd_tmp;
                            R_spostato = immagine_shiftata;
                            shift_riga_rossa_stringa = num2str(shift_riga);
                            shift_colonna_rossa_stringa = num2str(shift_colonna);
                        end
                    end
                end
            end
            % faccio lo stesso per il canale verde
            for shift_riga = -finestra:finestra
                for shift_colonna = -finestra:finestra
                    immagine_shiftata = circshift(single(handles.green_source), [shift_riga, shift_colonna]);
                    ssd_tmp = sum(sum((uint8(immagine_shiftata) - handles.green_source).^2));
                    if ssd_minimo == 0 % direttamente posso sostituire il valore
                        ssd_minimo = ssd_tmp;
                        G_spostato = immagine_shiftata;
                        shift_riga_verde_stringa = num2str(shift_riga);
                        shift_colonna_verde_stringa = num2str(shift_colonna);
                    else if ssd_tmp < ssd_minimo % aggiorno l'SSD
                            ssd_minimo = ssd_tmp;
                            G_spostato = immagine_shiftata;
                            shift_riga_verde_stringa = num2str(shift_riga);
                            shift_colonna_verde_stringa = num2str(shift_colonna);
                        end
                    end
                end
            end
            handles.output_image = cat(3,R_spostato,G_spostato,handles.blue_source);
    end
    set(handles.output_axes,'Visible','On');
    axes(handles.output_axes);
    imshow(handles.output_image, []);
    guidata(hObject,handles);
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton5 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [FileName, PathName,FilterIndex] = uiputfile({'*.jpg';'*.gif';'*.png';'*.bmp';'*.tiff'}, 'Save As');
    Name = fullfile(PathName, FileName);
    switch(FilterIndex)
        case 1
            imwrite(handles.output_image, Name, 'jpg');
        case 2
            imwrite(handles.output_image, Name, 'gif');
        case 3
            imwrite(handles.output_image, Name, 'png');
        case 4
            imwrite(handles.output_image, Name, 'bmp');
        case 5
            imwrite(handles.output_image, Name, 'tiff');
    end
    msgbox('Saved!');
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
    % hObject    handle to popupmenu1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from popupmenu1
end
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to popupmenu1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called
    
    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function response=isrgb(image)
    if (size(image,3)==3) response = 1;
    else response = 0;
    end
end
