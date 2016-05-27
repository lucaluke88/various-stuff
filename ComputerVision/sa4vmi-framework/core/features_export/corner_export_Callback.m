%% SAV4MI framework - Corner export callback
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function corner_export_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
        corner = handles.valid_corners;
        corner.features = handles.features;
        save(fullfile(PathName,FileName),'corner');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end