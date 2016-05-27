function files=getMetricList()
    try
        files = getfield(what('metrics'), 'm');
        % da inserire la modalità di esclusione: io inserisco i nomi di
        % metriche
        % secondarie (*.m) in un file excluded_metrics.txt e lo uso come filtro
        % di pulizia per il mio popup
        if exist(fullfile('settings','exclude_metrics.txt'), 'file') == 2
            fid = fopen(fullfile('settings','exclude_metrics.txt')); % leggimi il file di esclusione
            tline = fgetl(fid);
            k = 1;
            while ischar(tline)
                files = trim_list(files,tline);
                tline = fgetl(fid);
                k = k+1;
            end
            fclose(fid);
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end

function [trimmed_list]=trim_list(list,stringa)
    try
        idx = ismember(list,stringa);
        list(idx) = [];
        trimmed_list = list;
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end