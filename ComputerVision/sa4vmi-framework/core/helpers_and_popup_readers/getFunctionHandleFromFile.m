function functionHandle = getFunctionHandleFromFile( fullFileName )
    try
    [pathstr, name, ~] = fileparts(fullFileName);
    
    prevDir = pwd;
    
    cd(pathstr);
    functionHandle = str2func(name);
    cd(prevDir);
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end