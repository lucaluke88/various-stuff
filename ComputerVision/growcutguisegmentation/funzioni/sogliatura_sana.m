function [new_binary] = sogliatura_sana(binaryImage,hObject,handles)
    %SOGLIATURA_SANA Summary of this function goes here
    %   Detailed explanation goes here
    regione = handles.immagine_originale(binaryImage);
    assignin('base','regione',regione);
    new_binary = 1;
    guidata(hObject,handles);
end

