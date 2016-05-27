function [output]=kmeans_rgb(he,cluster)
    
    %     Convert the image to L*a*b* color space using makecform and applycform.
    cform = makecform('srgb2lab');
    lab_he = applycform(he,cform);
    %      Classify the Colors in 'a*b*' Space Using K-Means Clustering
    ab = double(lab_he(:,:,2:3));
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
    
    nColors = 3;
    % repeat the clustering 3 times to avoid local minima
    [cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
        'Replicates',3);
    %     Label Every Pixel in the Image Using the Results from KMEANS
    pixel_labels = reshape(cluster_idx,nrows,ncols);
    % Create Images that Segment the H&E Image by Color.
    segmented_images = cell(1,3);
    rgb_label = repmat(pixel_labels,[1 1 3]);
    
    for k = 1:nColors
        color = he;
        color(rgb_label ~= k) = 0;
        segmented_images{k} = color;
    end
    output = segmented_images{cluster};
    
end