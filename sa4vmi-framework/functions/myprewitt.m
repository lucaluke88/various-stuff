%The Prewitt method finds edges using the Prewitt approximation to the derivative. It returns edges at those points where the gradient of I is maximum.
function [I]=myprewitt(image)
    I=edge(image,'prewitt');
end