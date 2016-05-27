% doppia soglia by Luca Luke
function [I]=doppia_soglia(image,min,max)
    I = image;
    I(I<min) = 0;
    compoundCondInd = (I < max) & (I > min);
    I(compoundCondInd) = 128;
    I(I>max) = 255;
end