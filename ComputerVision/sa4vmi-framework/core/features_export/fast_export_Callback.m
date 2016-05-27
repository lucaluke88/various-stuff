%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function fast_export_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
        corners = handles.corners; %#ok<*NASGU>
        save(fullfile(PathName,FileName),'corners');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end