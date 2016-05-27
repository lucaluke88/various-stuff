function [I]=highlight_zone(image,threshold)
    
    image = uint8(255*mat2gray(image));
    [pixel_center_x,pixel_center_y] = ginput(1);
    pixel_center_x = uint8(pixel_center_x);
    pixel_center_y = uint8(pixel_center_y);
    
    value=image(pixel_center_x,pixel_center_y);
    I = zeros(size(image,1),size(image,2));
    
    for i=1:size(image,1)
        for j=1:size(image,2)
            if (abs(image(i,j)-value)<threshold) I(i,j) = 255;
            end
        end
    end
    
    
end