%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework


function gen_grayscale_random_image_Callback(hObject, eventdata, handles)
    try
        handles.input_image = zeros(600,600);
        for x=1:600
            for y=1:600
                handles.input_image(x,y) = uint8(rand()*255);
            end
        end
        axes(handles.input_image_axes);
        imshow(handles.input_image,[]);
        set(findobj('Tag','execute_single_menu'),'Enable','On');
        set(findobj('Tag','color2gray_menu'),'Enable','On');
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end