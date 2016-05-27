function about_Callback(hObject, eventdata, handles)
    try
        logo = imread('about.png');
        figure;
        imshow(logo,[]);
        message = 'Developed by Luca Luke Costantino';
        title(message);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end