function [I]=mycanny_ts(image,thresh,sigma)
    I=edge(image,'canny',thresh,sigma);
end