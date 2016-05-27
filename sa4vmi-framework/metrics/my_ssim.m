function [score]=my_ssim(input_image,training_image)
    [score,~]= ssim(input_image,training_image);
end