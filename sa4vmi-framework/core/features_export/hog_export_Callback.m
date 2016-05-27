%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function hog_export_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
        hog.hogVisualization = handles.hogVisualization; %#ok<*NASGU>
        hog.features = handles.features;
        save(fullfile(PathName,FileName),'hog');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
