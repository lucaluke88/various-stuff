%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

function segmenta_ClickedCallback(hObject, ~, handles)
    global main_fig_handle;
    disp('labels segmenta');
    disp(unique(main_fig_handle.labels_input));
    handles.labels_output = adapter(handles.immagine_originale,main_fig_handle.labels_input);
    updatePreviews(hObject,handles);
end

%% Così se volessi cambiare algoritmo di segmentazione, potrei farlo senza alterare il resto del codice
% l'unica cosa è che devo passare un set di labels {-1,0,+1} e restituire
% un set {0,1}
function [labels_out] = adapter(img,labels)
    if(numel(unique(labels))~=3)
        error('Ho bisogno di campioni sia di pelle sana che di pelle malata!');
    else
        dt=whos('img');
        dtMB=dt.bytes*9.53674e-7;
        disp(strcat('Memoria occupata img:',num2str(dtMB),' MB'));
        labels_out = exec_Growcut(img,labels); % GROWCUT
    end
end

function labels_out = exec_Growcut(img,labels)
    [labels_out, ~] = growcut(img,labels); % For segmentation
    labels_out = medfilt2(labels_out,[3,3]); % smoothing
end
