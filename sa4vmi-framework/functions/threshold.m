function [I]=threshold(image,threshold_value)
image(image<threshold_value) = 0;
image(image>=threshold_value) = 255;
I = image;
