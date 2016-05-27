%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function varargout = sav4mi_gui(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
        'gui_Singleton',  gui_Singleton, ...
        'gui_OpeningFcn', @sav4mi_gui_OpeningFcn, ...
        'gui_OutputFcn',  @sav4mi_gui_OutputFcn, ...
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

function sav4mi_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    
    try
        handles.output = hObject;
        
        % adding all the required subfolders (with the core functions)
        
        addpath(fullfile('core'));
        addpath(fullfile('core','features_detection'));
        addpath(fullfile('core','features_matching'));
        addpath(fullfile('core','features_export'));
        addpath(fullfile('core','helpers_and_popup_readers'));
        addpath(fullfile('core','workspace_helper'));
        addpath(fullfile('core','image_helpers'));
        addpath(fullfile('core','image_cursors'));
        
        % workspace inizialitation
        inizialize_workspace(hObject, eventdata, handles); % inizialization
        handles.execution_number = 0;
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

% --- Outputs from this function are returned to the command line.
function varargout = sav4mi_gui_OutputFcn(hObject, eventdata, handles)
    varargout{1} = handles.output;
end

function edit_text_2_Callback(hObject, eventdata, handles)
    handles.par2 = str2double(get(hObject,'String'));
    guidata(hObject,handles);
end

function edit_text_2_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function edit_text_3_Callback(hObject, eventdata, handles)
    handles.par3 = str2double(get(hObject,'String'));
    guidata(hObject,handles);
end

function edit_text_3_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function edit_text_5_Callback(hObject, eventdata, handles)
    handles.par5 = str2double(get(hObject,'String'));
    guidata(hObject,handles);
end

function edit_text_4_Callback(hObject, eventdata, handles)
    handles.par4 = str2double(get(hObject,'String'));
    guidata(hObject,handles);
end

function edit_text_4_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function edit_text_5_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function edit_text_6_Callback(hObject, eventdata, handles)
    handles.par6 = str2double(get(hObject,'String'));
    guidata(hObject,handles);
    
    
end

function edit_text_6_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function edit_text_7_Callback(hObject, eventdata, handles)
    handles.par7 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function edit_text_7_CreateFcn(hObject, eventdata, handles) %#ok<*INUSD>
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function edit_text_8_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end

function edit_text_8_Callback(hObject, eventdata, handles)
    handles.par8 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function edit_text_9_Callback(hObject, eventdata, handles)
    handles.par9 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function edit_text_9_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end

function input_text_3_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function input_text_4_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function metric_edit_4_Callback(hObject, eventdata, handles)
    handles.metric_par_4 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function metric_edit_4_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end

function metric_edit_5_Callback(hObject, eventdata, handles)
    handles.metric_par_5 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function metric_edit_5_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end

function metric_edit_6_Callback(hObject, eventdata, handles)
    handles.metric_par_6 = str2double(get(hObject,'String'));
    guidata(hObject,handles);
end

function metric_edit_6_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end

function metric_edit_7_Callback(hObject, eventdata, handles)
    handles.metric_par_7 = str2double(get(hObject,'String'));
    guidata(hObject,handles);
end

function metric_edit_7_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end

function metric_edit_8_Callback(hObject, eventdata, handles)
    handles.metric_par_8 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function metric_edit_8_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function metric_edit_9_Callback(hObject, eventdata, handles)
    handles.metric_par_9 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function metric_edit_9_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function metric_edit_10_Callback(hObject, eventdata, handles)
    handles.metric_par_10 = str2double(get(hObject,'String'));
    guidata(hObject,handles); 
end

function metric_edit_10_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function info_box_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function info_metric_box_Callback(hObject, eventdata, handles)
end

function info_metric_box_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function popup_functions_Callback(hObject, eventdata, handles) % appena clicco su un elemento del menu di popup
    try
        handles.function_name = change_popup_function(hObject, eventdata, handles);
        showHelp(hObject, eventdata, handles);
        guidata(hObject,handles); 
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function popup_functions_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
end


function popup_functions_ButtonDownFcn(hObject, eventdata, handles)
end

function popup_functions_KeyPressFcn(hObject, eventdata, handles)
end

function comparison_metric_Callback(hObject, eventdata, handles)
end

function comparison_metric_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

function popup_similarity_Callback(hObject, eventdata, handles)
    try
        handles.metric_name = change_popup_metric(hObject, eventdata, handles);
        showMetricHelp(hObject, eventdata, handles);
        guidata(hObject,handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function popup_similarity_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function open_exclusion_file_menu_Callback(hObject, eventdata, handles)
    try
        if exist(fullfile('settings','exclude_functions.txt'), 'file') ~= 2
            fid = fopen(fullfile('settings','exclude_functions.txt'), 'wt' );
            fclose(fid);
        end
        if(ispc)
            winopen(fullfile('settings','exclude_functions.txt'));
        else
            open(fullfile('settings','exclude_functions.txt'));
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function open_exclusion_metric_menu_Callback(hObject, eventdata, handles)
    try
        if exist(fullfile('settings','exclude_metrics.txt'), 'file') ~= 2
            fid = fopen( fullfile('settings','exclude_metrics.txt'), 'wt' );
            fclose(fid);
        end
        if(ispc)
            winopen(fullfile('settings','exclude_metrics.txt'));
        else
            open(fullfile('settings','exclude_metrics.txt'));
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function hist_input_button_Callback(hObject, eventdata, handles)
    try
        nBinsInput = inputdlg('number of Bins','Input');
        nBins = str2num(nBinsInput{1}); %#ok<*ST2NM>
        if iscell(handles.input_image)
            plot_hist(handles.input_image{handles.input_image_cursor},nBins);
        else 
            plot_hist(handles.input_image,nBins);
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function hist_output_button_Callback(hObject, eventdata, handles)
    try
        nBinsInput = inputdlg('number of Bins','Input');
        nBins = uint8(str2num(nBinsInput{1}));
        if iscell(handles.output_image)
            plot_hist(handles.output_image{handles.output_image_cursor},nBins);
        else
            plot_hist(handles.output_image,nBins);
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function help_Callback(hObject, eventdata, handles)
    try
        if exist(fullfile('settings','help.txt'), 'file') == 2
            if(ispc)
                winopen(fullfile('settings','help.txt'));
            else
                open(fullfile('settings','help.txt'));
            end
        else
            errordlg('Help file not found!','Error');
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function refresh_similarities_button_Callback(hObject, eventdata, handles)
    try
        set(handles.popup_similarity,'String',getMetricList(),'Value',1);
        handles.metric_name = change_popup_metric(hObject, eventdata, handles);
        showHelp(hObject, eventdata, handles);
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function refresh_function_button_Callback(hObject, eventdata, handles)
    try
        set(handles.popup_functions,'String',getFunctionList(),'Value',1);
        handles.function_name = change_popup_function(hObject, eventdata, handles);
        showHelp(hObject, eventdata, handles);
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function features_supermenu_Callback(hObject, eventdata, handles)
end


function feature_matching_supermenu_Callback(hObject, eventdata, handles)
end

function features_super_super_menu_Callback(hObject, eventdata, handles)
end

function execute_menu_Callback(hObject, eventdata, handles)
end

function workspace_menu_Callback(hObject, eventdata, handles)
end

function figure1_ResizeFcn(hObject, eventdata, handles)
end

function import_supermenu_Callback(hObject, eventdata, handles)
end

function settings_menu_Callback(hObject, eventdata, handles)
end

function gen_sample_supermenu_Callback(hObject, eventdata, handles)
end

function web_supermenu_Callback(hObject, eventdata, handles)
end


function open_mathworks_Callback(hObject, eventdata, handles)
    try
        term = inputdlg('Insert your term here','Search on Mathworks');
        url = strcat('http://www.mathworks.com/searchresults/?c%255B%255D=entiresite&q=',term{1});
        web(url);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function open_pubmed_Callback(hObject, eventdata, handles)
    try
        term = inputdlg('Insert your term here','Search on PubMed');
        url = strcat('http://www.ncbi.nlm.nih.gov/pubmed/?term=',term{1});
        web(url);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function classification_supermenu_Callback(hObject, eventdata, handles)
end

function feature_export_supermenu_Callback(hObject, eventdata, handles)
end

function help_supermenu_Callback(hObject, eventdata, handles)
end

function help_html_Callback(hObject, eventdata, handles)
    try
        if exist(fullfile('settings','help.html'), 'file') == 2
            if(ispc)
                winopen(fullfile('settings','help.html'));
            else
                open(fullfile('settings','help.html'));
            end
        else
            errordlg('Help file not found!','Error');
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function help_pdf_Callback(hObject, eventdata, handles)
    try
        if exist(fullfile('settings','help.pdf'), 'file') == 2
            if(ispc)
                winopen(fullfile('settings','help.pdf'));
            else
                open(fullfile('settings','help.pdf'));
            end
        else
            errordlg('Help file not found!','Error');
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function benchmark_supermenu_Callback(hObject, eventdata, handles)
end


% --------------------------------------------------------------------
function export_gp_graph_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,FilterIndex] = uiputfile({'*.jpg';'*.gif';'*.png';'*.bmp';'*.tiff';'*.dcm'}, 'Save As');
        Name = fullfile(PathName, FileName);
        
        F = getframe(handles.global_performance_axes);
        X = frame2im(F);
        switch(FilterIndex)
            case 1
                imwrite(X, Name, 'jpg');
            case 2
                imwrite(X, Name, 'gif');
            case 3
                imwrite(X, Name, 'png');
            case 4
                imwrite(X, Name, 'bmp');
            case 5
                imwrite(X, Name, 'tiff');
            case 6
                dicomwrite(X,Name);
        end
        msgbox('Saved!');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end


% --------------------------------------------------------------------
function export_i2ip_graph_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,FilterIndex] = uiputfile({'*.jpg';'*.gif';'*.png';'*.bmp';'*.tiff';'*.dcm'}, 'Save As');
        Name = fullfile(PathName, FileName);
        
        F = getframe(handles.performance_analyzer_axes);
        X = frame2im(F);
        switch(FilterIndex)
            case 1
                imwrite(X, Name, 'jpg');
            case 2
                imwrite(X, Name, 'gif');
            case 3
                imwrite(X, Name, 'png');
            case 4
                imwrite(X, Name, 'bmp');
            case 5
                imwrite(X, Name, 'tiff');
            case 6
                dicomwrite(X,Name);
        end
        msgbox('Saved!');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end


% --------------------------------------------------------------------
function export_similarity_graph_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,FilterIndex] = uiputfile({'*.jpg';'*.gif';'*.png';'*.bmp';'*.tiff';'*.dcm'}, 'Save As');
        Name = fullfile(PathName, FileName);
        
        F = getframe(handles.similarity_axes);
        X = frame2im(F);
        switch(FilterIndex)
            case 1
                imwrite(X, Name, 'jpg');
            case 2
                imwrite(X, Name, 'gif');
            case 3
                imwrite(X, Name, 'png');
            case 4
                imwrite(X, Name, 'bmp');
            case 5
                imwrite(X, Name, 'tiff');
            case 6
                dicomwrite(X,Name);
        end
        msgbox('Saved!');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
