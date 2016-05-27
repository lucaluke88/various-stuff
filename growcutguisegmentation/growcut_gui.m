%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

%% Per compilare su 64BIT
%  mex -largeArrayDims -DA64BITS


function varargout = growcut_gui(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
        'gui_Singleton',  gui_Singleton, ...
        'gui_OpeningFcn', @growcut_gui_OpeningFcn, ...
        'gui_OutputFcn',  @growcut_gui_OutputFcn, ...
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
end

function growcut_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    init(hObject, eventdata, handles);
end

function varargout = growcut_gui_OutputFcn(hObject, eventdata, handles)
    varargout{1} = handles.output;
end

% altre funzioni di inizializzazione
function init(hObject, eventdata, handles)
    global main_fig_handle
    handles.immagine_aperta = 0; % non abbiamo aperto ancora nessuna immagine
    handles.fototipo = 1; % impostiamo manualmente il fototipo
    handles.output = hObject;
    addpath(fullfile('growcut'));
    addpath(fullfile('funzioni'));
    main_fig_handle = handles; % per l'altra GUI
    guidata(hObject,handles);
end

% pelle sana in anteprima sana
function segnapellesana_sana_Callback(hObject, eventdata, handles)
    marcatura_azione('anteprima_sana','sana',hObject,handles);
end

% pelle malata in anteprima sana
function segnapellemalata_sana_Callback(hObject, eventdata, handles)
    marcatura_azione('anteprima_sana','malata',hObject,handles);
end

% pelle sana in anteprima malata
function segnapellesana_malata_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
    marcatura_azione('anteprima_malata','sana',hObject,handles);
end

% pelle malata in anteprima malata
function segnapellemalata_malata_Callback(hObject, eventdata, handles) %#ok<*INUSL>
    marcatura_azione('anteprima_malata','malata',hObject,handles);
end

% pelle sana in anteprima originale
function segnaoriginale_pellesana_Callback(hObject, eventdata, handles)
    marcatura_azione('originale','sana',hObject,handles);
end

% pelle malata in anteprima originale
function segnaoriginale_pellemalata_Callback(hObject, eventdata, handles)
    marcatura_azione('originale','malata',hObject,handles);
end

% cancello in anteprima originale
function cancella_orig_Callback(hObject, eventdata, handles)
    marcatura_azione('originale','cancella',hObject,handles);
end

% cancello in anteprima sana
function cancella_sana_Callback(hObject, eventdata, handles)
    marcatura_azione('anteprima_sana','cancella',hObject,handles);
end

% cancello in anteprima malata
function cancella_malata_Callback(hObject, eventdata, handles)
    marcatura_azione('anteprima_malata','cancella',hObject,handles);
end

function segnarettangolo_Callback(hObject, eventdata, handles)
    segna_area(hObject, eventdata, handles);
end

function salva_risultato_ClickedCallback(hObject, eventdata, handles) %#ok<*INUSD>
    export(hObject,eventdata,handles);
end



% campo patologia
function edit1_Callback(hObject, eventdata, handles)
    handles.patologia = get(hObject,'string');
    guidata(hObject,handles);
end

function edit1_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% campo nome e cognome
function edit2_Callback(hObject, eventdata, handles)
    handles.nomecognome = get(hObject,'string');
    guidata(hObject,handles);
end

function edit2_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% campo giorno
function edit3_Callback(hObject, eventdata, handles)
    handles.giorno = get(hObject,'string');
    guidata(hObject,handles);
end

function edit3_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function segmenta_Callback(hObject, eventdata, handles)
    segmenta_ClickedCallback(hObject, eventdata, handles);
end

% campo mese
function edit5_Callback(hObject, eventdata, handles)
    handles.mese = get(hObject,'string');
    guidata(hObject,handles);
end

function edit5_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% campo anno
function edit6_Callback(hObject, eventdata, handles)
    handles.anno = get(hObject,'string');
    guidata(hObject,handles);
end

function edit6_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function color_patch_sana_Callback(hObject, eventdata, handles)
    % seleziono un'area, calcolo la media e la varianza e su di quella
    % faccio il threshold, da implementare
    etichetta('sana_patch','immagine_originale',hObject,handles);
end

function gestione_lavoro_supermenu_Callback(hObject, eventdata, handles)
end

function fototipo_popup_Callback(hObject, eventdata, handles)
    handles.fototipo = str2double(get(hObject,'Value'));
    guidata(hObject,handles);
end

function fototipo_popup_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function figure1_KeyPressFcn(hObject, eventdata, handles)
end
