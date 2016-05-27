function [output]=is_rgb(image)
    try
        % restituisce 1 se l'immagine è RGB, 0 altrimenti
        if size(image,3) == 3 % le immagini RGB si presentano come matrici m x n x 3
            output = 1;
        else output = 0;
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end
