clear all;
close all;
load('qu2_data.mat');
HISTOGRAMS = vq_sift_luke('data',dictionary);
figure; imagesc(HISTOGRAMS);
kmax = 21;
history = [];
cont = 0;
for K=1:2:kmax
    cont = cont + 1;
    [ACCURACY,PREDICTED_LABELS] = classify_nn_luke(TRAIN_IND,TEST_IND,TRAIN_LABEL,TEST_LABEL,HISTOGRAMS,K);
    history(cont,:) = [K,ACCURACY];
end
plot(history(:,1),history(:,2));
xlabel('numero di vicini');
ylabel('accuracy in %');