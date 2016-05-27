%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function mser_export_Callback(hObject, eventdata, handles)
    try
        [FileName, PathName,~] = uiputfile('*.mat', 'Save As');
        regions = handles.regions; %#ok<*NASGU>
        save(fullfile(PathName,FileName),'regions');
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end