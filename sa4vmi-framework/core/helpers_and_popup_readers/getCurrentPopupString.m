function str = getCurrentPopupString(hh)
    %# getCurrentPopupString returns the currently selected string in the popupmenu with handle hh
    %# could test input here
    try
        if ~ishandle(hh) || strcmp(get(hh,'Type'),'popupmenu')
            error('getCurrentPopupString needs a handle to a popupmenu as input')
        end
        
        %# get the string - do it the readable way
        list = get(hh,'String');
        val = get(hh,'Value');
        if iscell(list)
            str = list{val};
        else
            str = list(val,:);
        end
    catch err
        errordlg(getReport(err,'basic','hyperlinks','off'));
    end
end