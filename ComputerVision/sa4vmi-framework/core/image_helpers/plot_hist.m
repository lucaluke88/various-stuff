%% SAV4MI framework
% Author : Luca Luke Costantino (lucaluke.altervista.org)
% Source : github.com/lucaluke88/sav4mi-framework
function plot_hist(image,nBins)
    try
        figure();
        if is_rgb(image)
            
            %Split into RGB Channels
            Red = image(:,:,1);
            Green = image(:,:,2);
            Blue = image(:,:,3);
            
            %Get histValues for each channel
            [yRed, x] = imhist(Red,nBins);
            [yGreen, x] = imhist(Green,nBins);
            [yBlue, x] = imhist(Blue,nBins);
            
            %Plot them together in one plot
            plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue');
        else
            imhist(image,nBins);
        end
    catch error
        errordlg(getReport(error,'basic','hyperlinks','off'));
    end
end