% Mostriamo nell'info box sottostante l'area dei parametri l'eventuale
% guida alla funzione (se presente). Altrimenti direttamente il codice.
% il file di help ha titolo "nomefunzione.m.txt"

function [file_content,help_found]=parse_metric_help(function_name)
    try
    file_content = ''; % contenuto iniziale dell'info box (inizializzazione)
    if exist(fullfile('metrics',strcat(function_name,'.txt')), 'file') == 2
        fid = fopen(fullfile('metrics',strcat(function_name,'.txt'))); % leggimi il file di help
        help_found = 1;
    else % se non c'è la guida, leggimi il codice
        fid = fopen(fullfile('metrics',function_name));
        help_found = 0;
    end
    tline = fgetl(fid);
    while ischar(tline)
        file_content = strcat(file_content,tline); % qui andrebbe inserito l'invio a capo
        tline = fgetl(fid);
    end
    fclose(fid);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end