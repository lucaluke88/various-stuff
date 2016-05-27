%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
% Addestratore del TS
%%

function etichetta(label,where,hObject,handles)
    
    try
        set(1,'DefaultFigureMenu','none'); % leviamo menu e toolbar che sono inutili in questo caso
        switch where
            case 'anteprima_malata'
                hfig = figure('name',strcat('Etichettatura della pelle ',label,' sull'' anteprima malata'));
                imshow(handles.anteprima_malata);
            case 'anteprima_sana'
                hfig = figure('name',strcat('Etichettatura della pelle ',label,' sull'' anteprima sana'));
                imshow(handles.anteprima_sana);
            case 'immagine_originale'
                hfig = figure('name',strcat('Etichettatura della pelle ',label,' sull'' anteprima delle marcature'));
                imshow(handles.anteprima_marcature);
        end
        
        while 1
            hFH = imfreehand(gca);
            binaryImage = uint8(hFH.createMask());
            binaryImage = abs(1 - binaryImage); % mi viene più semplice colorare la zona
            
            switch label
                case 'sana' % etichettatura normale
                    handles.anteprima_marcature(:,:,2) = handles.anteprima_marcature(:,:,2) .* binaryImage;
                    handles.anteprima_marcature(:,:,1) = handles.anteprima_marcature(:,:,1) .* binaryImage;
                    handles.labels_input(~binaryImage) = 1;
                case 'malata' % etichettatura malata
                    handles.anteprima_marcature(:,:,2) = handles.anteprima_marcature(:,:,2) .* binaryImage;
                    handles.anteprima_marcature(:,:,3) = handles.anteprima_marcature(:,:,3) .* binaryImage;
                    handles.labels_input(~binaryImage) = -1;
                case 'sana_patch' % primo thresholding
                    handles.anteprima_marcature(:,:,1) = handles.anteprima_marcature(:,:,1) .* binaryImage;
                    handles.anteprima_marcature(:,:,3) = handles.anteprima_marcature(:,:,3) .* binaryImage;
                    sogliatura_sana(binaryImage,hObject,handles);
                case 'cancella'
                    handles.anteprima_marcature(handles.labels_input(~binaryImage),:) = handles.immagine_originale(handles.labels_input(~binaryImage),:);
                    handles.labels_input(~binaryImage) = 0;
            end
            
            imshow(handles.anteprima_marcature,'Parent',handles.axes_im_originale);
            guidata(hObject,handles);
        end
    catch % ho chiuso l'anteprima grande di marcatura
        if handles.immagine_aperta
            robot = java.awt.Robot;
            robot.keyPress    (java.awt.event.KeyEvent.VK_ESCAPE);
            robot.keyRelease  (java.awt.event.KeyEvent.VK_ESCAPE);
            toggleButtons('reset','aa',hObject,handles);
        end
    end
end