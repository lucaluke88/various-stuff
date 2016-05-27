function varargout = marcatura(varargin)
    
    % MARCATURA MATLAB code for marcatura.fig
    %      MARCATURA, by itself, creates a new MARCATURA or raises the existing
    %      singleton*.
    %
    %      H = MARCATURA returns the handle to a new MARCATURA or the handle to
    %      the existing singleton*.
    %
    %      MARCATURA('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in MARCATURA.M with the given input arguments.
    %
    %      MARCATURA('Property','Value',...) creates a new MARCATURA or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before marcatura_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to marcatura_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES
    
    % Edit the above text to modify the response to help marcatura
    
    % Last Modified by GUIDE v2.5 14-Jul-2015 11:12:01
    
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
        'gui_Singleton',  gui_Singleton, ...
        'gui_OpeningFcn', @marcatura_OpeningFcn, ...
        'gui_OutputFcn',  @marcatura_OutputFcn, ...
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

% --- Executes just before marcatura is made visible.
function marcatura_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to marcatura (see VARARGIN)
    
    % Choose default command line output for marcatura
    global main_fig_handle;
    handles.output = hObject;
    
    imshow(main_fig_handle.anteprima_marcature,'Parent',handles.axes1);
    etichetta(hObject, eventdata, handles);
    % Update handles structure
    %guidata(hObject, handles);
    
    % UIWAIT makes marcatura wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = marcatura_OutputFcn(hObject, eventdata, handles)
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Get default command line output from handles structure
    try
        varargout{1} = handles.output;
    catch
        varargout{1} = 0;
    end
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
    global etichetta;
    etichetta = 'sana';
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles) %#ok<*INUSD>
    global etichetta;
    etichetta = 'malata';
end

function etichetta(hObject, ~, handles)
    global etichetta; % la mia label attuale di marcatura
    global immagine; % che immagine sto mostrando in preview
    global main_fig_handle; % handle della figura principale
    try
        while 1
            roi = imfreehand(gca);
            mask = roi.createMask();
            mask = ~mask;
            uint_mask = uint8(mask);
            switch etichetta
                case 'sana' % etichettatura normale
                    immagine(:,:,1) = immagine(:,:,1) .* uint_mask;
                    immagine(:,:,2) = immagine(:,:,2) .* uint_mask;
                    main_fig_handle.labels_input(~mask) = 1;
                case 'malata' % etichettatura malata
                    immagine(:,:,2) = immagine(:,:,2) .* uint_mask;
                    immagine(:,:,3) = immagine(:,:,3) .* uint_mask;
                    main_fig_handle.labels_input(~mask) = -1;
            end
            imshow(immagine,'Parent',gca);
            main_fig_handle.anteprima_marcature = immagine;
            guidata(hObject,handles);
            disp('labels dopo marcatura');
            disp(unique(main_fig_handle.labels_input));
        end
    catch
        
    end
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
    global main_fig_handle;
    imshow(main_fig_handle.anteprima_marcature,'Parent',main_fig_handle.axes_im_originale);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
    delete(hObject);
end
