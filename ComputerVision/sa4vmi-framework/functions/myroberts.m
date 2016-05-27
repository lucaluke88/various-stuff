%The Roberts method finds edges using the Roberts approximation to the derivative. It returns edges at those points where the gradient of I is maximum.
function [I]=myroberts(image)
    I=edge(image,'roberts');
end