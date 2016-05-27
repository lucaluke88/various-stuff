%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function load_matlab_sample_Callback(hObject, eventdata, handles)
    try
        selection = uint8(rand()*7);
        
        switch selection
            case 0
                handles.input_image = imread('cameraman.tif');
                handles.FileName = 'cameraman.tif';
            case 1
                handles.input_image = imread('tissue.png');
                handles.FileName = 'tissue.png';
            case 2
                handles.input_image = imread('board.tif');
                handles.FileName = 'board.tif';
            case 3
                handles.input_image = imread('pout.tif');
                handles.FileName = 'pout.tif';
            case 4
                handles.input_image = imread('tire.tif');
                handles.FileName = 'tire.tif';
            case 5
                handles.input_image = imread('rice.png');
                handles.FileName = 'rice.png';
            case 6
                handles.input_image = imread('cell.tif');
                handles.FileName = 'cell.tif';
            case 7
                handles.input_image = imread('hestain.png');
                handles.FileName = 'hestain.png';
                
        end
        
        axes(handles.input_image_axes);
        imshow(handles.input_image,[]);
        set(findobj('Tag','previous_input_image_button'),'Enable','Off');
        set(findobj('Tag','next_input_image_button'),'Enable','Off');
        
        set(findobj('Tag','previous_output_image_button'),'Enable','Off');
        set(findobj('Tag','next_output_image_button'),'Enable','Off');
        set(findobj('Tag','previous_compare_button'),'Enable','Off');
        set(findobj('Tag','next_compare_button'),'Enable','Off');
        set(findobj('Tag','color2gray_menu'),'Enable','On');
        set(findobj('Tag','color2grayall_menu'),'Enable','Off');
        set(findobj('Tag','input_image_axes'),'Visible','On');
        set(findobj('Tag','histeq_menu'),'Enable','On');
        set(findobj('Tag','histeqall_menu'),'Enable','Off');
        
        if is_rgb(handles.input_image)
            image_name = strcat(handles.FileName,' [RGB]');
        else
            image_name = strcat(handles.FileName,' [GRAY]');
        end
        set(findobj('Tag','current_input_image_name_and_number'),'String',image_name);
        
        set(findobj('Tag','execute_single_menu'),'Enable','On');
        set(findobj('Tag','execute_all_menu'),'Enable','Off');
        set(findobj('Tag','hist_input_button'),'Enable','On');
        set(findobj('Tag','features_supermenu'),'Enable','On');
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end