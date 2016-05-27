function [I]=mycanny(image)
    I=edge(image,'canny');
end