%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function [score]=compute_similarity(hObject, eventdata, handles,input_image,training_image)
    try
        % prenormalizziamo
        input_image = uint8(255*mat2gray(input_image));
        training_image = uint8(255*mat2gray(training_image));
        
        % leggo dal popup che metriaa usare e applicarla
        
        mymetric = getCurrentPopupString(handles.popup_similarity); % mi ricavo la voce scelta
        nameOf = getFunctionHandleFromFile(fullfile('metrics',mymetric));
        if(nargin(nameOf)>2)
            switch(nargin(nameOf))
                case 3
                    score = nameOf(input_image,training_image,handles.metric_par_4);
                case 4
                    score = nameOf(input_image,training_image,handles.metric_par_4,handles.metric_par_5);
                case 5
                    score = nameOf(input_image,training_image,handles.metric_par_4,handles.metric_par_5,handles.metric_par_6);
                case 6
                    score = nameOf(input_image,training_image,handles.metric_par_4,handles.metric_par_5,handles.metric_par_6,handles.metric_par_7);
                case 7
                    score = nameOf(input_image,training_image,handles.metric_par_4,handles.metric_par_5,handles.metric_par_6,handles.metric_par_7,handles.metric_par_8);
                case 8
                    score = nameOf(input_image,training_image,handles.metric_par_4,handles.metric_par_5,handles.metric_par_6,handles.metric_par_7,handles.metric_par_8,handles.metric_par_9);
                case 9
                    score = nameOf(input_image,training_image,handles.metric_par_4,handles.metric_par_5,handles.metric_par_6,handles.metric_par_7,handles.metric_par_8,handles.metric_par_9,handles.metric_par_10);
                case 10
                    score = nameOf(input_image,training_image,handles.metric_par_4,handles.metric_par_5,handles.metric_par_6,handles.metric_par_7,handles.metric_par_8,handles.metric_par_9,handles.metric_par_10,handles.metric_par_11);
                    
            end
        else
            score = nameOf(input_image,training_image);
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end