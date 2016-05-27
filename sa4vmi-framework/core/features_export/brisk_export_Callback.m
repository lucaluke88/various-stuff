%% SAV4MI framework - Brisk export callback
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function brisk_export_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
        points = handles.points; %#ok<*NASGU>
        save(fullfile(PathName,FileName),'points');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end