function functionHandle = getFunctionHandleFromFile( fullFileName )
    
    [pathstr, name, ~] = fileparts(fullFileName);
    
    prevDir = pwd;
    
    cd(pathstr);
    functionHandle = str2func(name);
    cd(prevDir);
end