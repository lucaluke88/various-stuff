function [f]=histogram(Im1,Im2)


% Im1 = rgb2gray(Im1);
% Im2 = rgb2gray(Im2);

%  convert images to type double (range from from 0 to 1 instead of from 0 to 255)

Im1 = im2double(Im1);
Im2 = im2double(Im2);

% Calculate the Normalized Histogram of Image 1 and Image 2
hn1 = imhist(Im1)./numel(Im1);
hn2 = imhist(Im2)./numel(Im2);

% Calculate the histogram error
f = sum((hn1 - hn2).^2);

end