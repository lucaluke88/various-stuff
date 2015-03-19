function HISTOGRAMS = vq_sift_luke(SIFT_FILE_PATH,DICTIONARY)

%%% get list of all precomputed SIFT files
file_names = dir([SIFT_FILE_PATH,'/image*sift.mat']);

%%% get size of visual dictionary
nBins = size(DICTIONARY,1);

%%% Setup output
HISTOGRAMS = zeros(length(file_names),nBins);

%%% Main loop over SIFT files.

for i=1:length(file_names)
    %%% Load in each SIFT file for each image
    load([SIFT_FILE_PATH,'/',file_names(i).name]);
    %%% Get all SIFT descriptors for the image
    sifts = features.data;
    %%% How many in this image?
    nSift = size(sifts,1);
    %%% Now loop over all SIFT descriptors in image
    
    % usando knnsearch le performance sono di gran lunga migliori
    [idx, ~] = knnsearch(DICTIONARY, sifts, 'Distance', 'euclidean'); 
    for j = 1:nSift
        %%% Find the closest DICTIONARY element. Use squared Euclidean distance
        
        HISTOGRAMS(i, idx(j)) = HISTOGRAMS(i, idx(j)) +1; 

        % METODO INEFFICIENTE : CONFRONTO MANUALE
        %         distanza = inf;
        %         closest_id = 0;
        %         for k=1:size(DICTIONARY)
        %             
        %             % distanza euclidea ottimizzata per matrici grandi
        %             V = sifts(j,:) - DICTIONARY(k,:);
        %             distanza_tmp = sqrt(V * V');
        %             % aggiornamento della distanza minima trovata e il suo id
        %             if(distanza_tmp < distanza)
        %                 distanza = distanza_tmp;
        %                 closest_id = k;
        %             end
        %         end
        % ora so quale elemento del dizionario è più vicino al descrittore in analisi.
        % Increment HISTOGRAMS count
        %HISTOGRAMS(i,closest_id) = HISTOGRAMS(i,closest_id) + 1;
    end
end

