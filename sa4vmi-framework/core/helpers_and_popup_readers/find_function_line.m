function [C]=find_function_line(myfile)
    try
        ok = 0;
        cont = 1;
        while(ok == 0)
            [C,~]=strsplit(myfile{cont},{'(',')',',','=',' ','  '});
            if(strcmp(C{1},'function'))
                ok = 1;
                [C,~]=strsplit(myfile{cont},{'(',')'});
                [C,~]=strsplit(C{2},{','});
            else
                cont = cont + 1;
            end
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end