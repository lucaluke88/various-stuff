% questo teorema di statistica mi permette di approssimare la distribuzione
% e la media di una popolazione molto grande di individui mediante K passi
% di sampling. Ad ogni passo, preleviamo N individui, facciamo la media dei
% campioni e costruiamo
% una metapopolazione di medie. Questa metapopolazione avrà come
% distribuzione gaussiana con media uguale a quella reale e come varianza
% S/sqrt(N)



clear all;

% genero la mia popolazione (età di individui)

popolazione = zeros(10000,1);

for i=1:10000000
    popolazione(i) = randi([0 99],[1 1]); 
end

N = 50;

history = zeros(200,1); % storia con le medie della metapopolazione (di K medie)

max_iter = 200;
for K=1:max_iter

    metapopolazione = zeros(K,1);

    i = 1;
    while i<K
        selezionati = randi([1 10000],[1 N]);
        sample = zeros(N,1);
        for j=1:N
            sample(j) = popolazione(selezionati(j));
        end
        if size(sample,2) == size(unique(sample),2) % evito di selezionare due volte lo stesso individuo nel sample
            i = i+1;
            metapopolazione(i) = mean(sample);
        end
    end
    history(K) = mean(metapopolazione);
end

figure;
hold on;
plot(1:max_iter,history,'Color','b');
line(1:max_iter,mean(popolazione),'Color','r');
disp('metapop');
disp(mean(metapopolazione));
disp('pop');
disp(mean(popolazione));

