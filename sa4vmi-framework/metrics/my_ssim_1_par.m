function [score]=my_ssim_1_par(input_image,training_image,parametro)
    [score,~]= ssim(input_image,training_image);
    display(parametro,'parametro');
end