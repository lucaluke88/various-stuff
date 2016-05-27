%% SAV4MI framework - SURF export
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function surf_export_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
        surf.features = handles.features;
        surf.points = handles.valid_points; %#ok<*NASGU>
        save(fullfile(PathName,FileName),'surf');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end