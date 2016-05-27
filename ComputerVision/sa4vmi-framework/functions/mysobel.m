%The Sobel method finds edges using the Sobel approximation to the derivative. It returns edges at those points where the gradient of I is maximum.
function [I]=mysobel(image)
    I=edge(image,'sobel');
end