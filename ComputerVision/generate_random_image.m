% generate random image

clear all;

height = input('Height >> ');
width = input('Width >> ');

I = zeros(height,width,3);

for y=1:width
    for x=1:height
        I(x,y,1) = uint8(rand*255)+1;
        I(x,y,2) = uint8(rand*255)+1;
        I(x,y,3) = uint8(rand*255)+1;
    end
end

% smooth

h = fspecial('gaussian');
for i=1:10
    if uint8(rand)
        I = imfilter(I,h);
    end
end

if uint8(rand)
        I = I/2;
end

imshow(uint8(I));
imwrite(uint8(I),'output.jpg','jpg');
