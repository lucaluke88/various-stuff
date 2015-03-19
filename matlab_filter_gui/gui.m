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
    
    % Last Modified by GUIDE v2.5 05-Nov-2014 22:40:34
    
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
    
    set(handles.popupmenu1,'String',getfield(what('filters'), 'm'),'Value',1);
    handles.filter_name = getCurrentPopupString(handles.popupmenu1); % mi ricavo la voce scelta
    
    guidata(hObject, handles);
    
    % UIWAIT makes gui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
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

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
    % hObject    handle to Untitled_1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function open_menu_Callback(hObject, eventdata, handles)
    % hObject    handle to open_menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.gif';'*.tiff';'*.bmp'},'Select the image(s)','MultiSelect', 'on');
    handles.input_image = imread(strcat(PathName,FileName));
    set(handles.axes1,'Visible','On');
    axes(handles.axes1);
    imshow(handles.input_image, []);
    guidata(hObject,handles);
end


% --------------------------------------------------------------------
function save_menu_Callback(hObject, eventdata, handles)
    % hObject    handle to save_menu (see GCBO)
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


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
    % hObject    handle to Untitled_2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function normalize_Callback(hObject, eventdata, handles)
    % hObject    handle to normalize (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    handles.input_image(:,1) = uint8(255*mat2gray(handles.input_image(:,1)));
    handles.input_image(:,2) = uint8(255*mat2gray(handles.input_image(:,2)));
    handles.input_image(:,3) = uint8(255*mat2gray(handles.input_image(:,3)));
    axes(handles.axes1);
    imshow(handles.input_image, []);
    guidata(hObject,handles);
end


% --------------------------------------------------------------------
function rgb2gray_menu_Callback(hObject, eventdata, handles)
    % hObject    handle to rgb2gray_menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    handles.input_image = rgb2gray(handles.input_image);
    axes(handles.axes1);
    imshow(handles.input_image, []);
    guidata(hObject,handles);
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


% --- Executes on button press in execute_button.
function execute_button_Callback(hObject, eventdata, handles)
    % hObject    handle to execute_button (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    nameOf = getFunctionHandleFromFile(fullfile('filters',handles.filter_name));
    handles.output_image = nameOf(handles.input_image);
    set(handles.axes2,'Visible','On');
    axes(handles.axes2);
    imshow(handles.output_image, []);
    guidata(hObject,handles);
end
