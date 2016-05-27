%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

function end_selection_ClickedCallback(hObject, ~, handles)
    global immagine_aperta;
    if immagine_aperta
        robot = java.awt.Robot;
        robot.keyPress    (java.awt.event.KeyEvent.VK_ESCAPE);
        robot.keyRelease  (java.awt.event.KeyEvent.VK_ESCAPE);
        toggleButtons('reset','aa',hObject,handles);
    end
end