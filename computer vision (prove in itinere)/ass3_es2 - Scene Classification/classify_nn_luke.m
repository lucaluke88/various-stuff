function [ACCURACY,PREDICTED_LABELS] = classify_nn_luke(TRAIN_IND,TEST_IND,TRAIN_LABELS,TEST_LABELS,HISTOGRAMS,K)

PREDICTED_LABELS = zeros(1,length(TEST_IND));    
%% Get set of *all* train histograms
all_train_hist = HISTOGRAMS(TRAIN_IND,:);

%% VERSIONE INEFFICIENTE DEL CODICE
% for i=1:length(TEST_IND)
%     
%     %%% Get histogram for test example i from HISTOGRAMS matrix
%     % prendo la riga k-esima degli istogrammi, dove k=TEST_IND(i)
%     id_test_ind_tmp = TEST_IND(i); %prendo l'ennesimo id dalle immagini di test
%     test_hist = HISTOGRAMS(id_test_ind_tmp,:);
%     %%% Compute squared Euclidean distance between test_hist and every
%     %%% histogram in all_train_hist
%     dist = ones(size(all_train_hist),2);
%     for j=1:size(all_train_hist,1)
%             V = test_hist - all_train_hist(j,:);
%             % dist(j,:) = [ id riga train con quella distanza | distanza effettiva ]
%             dist(j,:) = [j,sqrt(V * V')];
%     end
%     
%     %%% Feel free to try some other distance metric mentioned in the
%     %%% slides. Some of them might perform better than Euclidean distance.
%     
%     
%     %% Sort by distance and take closest K points.
%     dist=sortrows(dist,2);
%     closest_K_points = dist(1:K,1); % mi servono solo gli ID (dei traini, le distanze posso anche buttarle via
%     
%     %% Compute predicted label.
%     closest_K_labels = TRAIN_LABELS(1,closest_K_points);
%     % prendo la label che occorre più spesso
%     PREDICTED_LABELS(1,i) = mode(closest_K_labels);
%     
% end

% VERSIONE EFFICIENTE
all_test_hists = HISTOGRAMS(TEST_IND,:);
[idx,~] = knnsearch(all_train_hist,all_test_hists,'Distance','euclidean','k',K);
label = zeros(size(idx),K);
for i=1:length(TEST_IND)
    for j=1:K
        label(i,j) = TRAIN_LABELS(idx(i,j));
    end
    PREDICTED_LABELS(1,i) = mode(label(i,:));
    
end

%%% Compute ACCURACY, i.e. what fraction of the time does
%PREDICITED_LABELS agree with TEST_LABELS
ACCURACY = 0;
for i=1:length(TEST_IND)
    if TEST_LABELS(1,i)==PREDICTED_LABELS(1,i)
        ACCURACY = ACCURACY + 1;
    end
end
% esprimo accuracy in percentuale
ACCURACY = ACCURACY/length(TEST_IND);
