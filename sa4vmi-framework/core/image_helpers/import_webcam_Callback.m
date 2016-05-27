%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework

function import_webcam_Callback(hObject, eventdata, handles)
    % import from webcam
    try
        if(ispc)
            vid = videoinput('winvideo',1,'YUYV_640x480');
        else
            vid = videoinput('linuxvideo',1,'YUYV_640x480');
        end
        set(vid, 'ReturnedColorSpace', 'RGB');
        handles.input_image = getsnapshot(vid);
        axes(handles.input_image_axes);
        imshow(handles.input_image);
        guidata(hObject, handles);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end