%% pulizia ambiente di lavoro e importazione del dataset
clear all;
close all;
load train_test_orl.mat;
load ORL_32x32.mat
% faces
fea_training_set = fea(trainIdx,:);
fea_test_set = fea(testIdx,:);
% labels
gnd_training_set = gnd(trainIdx,:);
gnd_test_set = gnd(testIdx,:);
% %% Scaliamo le intensità in modo da passare da [0 255] a [0.0 1.0]
fea_training_set = mat2gray(fea_training_set);
fea_test_set = mat2gray(fea_test_set);
% calcolo la faccia media
mean_face = mean(fea_training_set);
% mostro il training set originale
figure; montage(reshape(fea_training_set'/1,[32 32 1 280]));
title('Training Set originale');
for i=1:size(fea_training_set)
    fea_training_set(i,:) = fea_training_set(i,:) - mean_face;
end

% anche per le immagini di test faccio la stessa cosa
mean_face_test = mean(fea_test_set);
for i=1:size(fea_test_set)
    fea_test_set(i,:) = fea_test_set(i,:) - mean_face_test;
end

% matrice di covarianza
C = fea_training_set' * fea_training_set;

k_max = 20; % imposto il numero massimo di componenti da selezionare nello spazio delle facce
success = zeros(1,k_max);
for K=1:k_max
    [v,~]=eigs(C,K); % autovalori dello spazio delle facce
    % se abbiamo preso il massimo numero di componenti che volevamo,
    % mostriamo le eigenfaces e le eigenfaces con la faccia media
    % riapplicata
    if K==k_max
        figure; montage(reshape(v/1,[32 32 1 K]));
        title('EigenFaces');
        v2 = v';
        for i=1:size(v2)
            v2(i,:) = v2(i,:) + mean_face;
        end
        v2 = v2';
        figure; montage(reshape(v2/1,[32 32 1 K]));
        title('EigenFaces con la faccia media aggiunta di nuovo');
    end
    
    % creo la matrice dei descrittori p
    p = fea_training_set * v;
    
    %% provo la correttezza del mio operato
    % ricostruisco il training set
    reconstructed_training_set = p * v';
    % aggiungo di nuovo la faccia media
    for i=1:size(reconstructed_training_set)
        reconstructed_training_set(i,:) = reconstructed_training_set(i,:) + mean_face;
    end
    if K==k_max
        figure; montage(reshape(reconstructed_training_set'/1,[32 32 1 280]));
        title('Training set ricostruito');
    end
    
    %% fase di test
    
    
    
    q = fea_test_set * v;
    [idx,~] = knnsearch(p,q,'Distance','euclidean');
    
    % vedo quanti label corretti ho trovato
    success(1,k_max) = 0;
    for i=1:size(fea_test_set)
        if gnd_training_set(idx(i))==gnd_test_set(i)
            success(1,K)=success(1,K)+1;
        end
    end
    
end
figure; bar([1:k_max],success(1,:));
title('Istogramma successo al variare di K');