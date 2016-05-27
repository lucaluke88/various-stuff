function [score]=my_psnr(input_image,training_image)
    [score,~]= psnr(input_image,training_image);
end