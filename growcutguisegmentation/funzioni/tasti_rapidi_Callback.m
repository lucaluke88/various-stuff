%% Growcut GUI per uso medico
% Autore Illuminato Luca Costantino
%%
function tasti_rapidi_Callback(~, ~, ~)
    aiuto = 'A - Apri immagine\n';
    aiuto = strcat(aiuto,'C - Cancella attuale lavoro\n');
    aiuto = strcat(aiuto,'E - Esegui l''algoritmo\n');
    aiuto = strcat(aiuto,'F - Finisci attuale selezione\n');
    aiuto = strcat(aiuto,'L - Carica dati nell''area di lavoro\n');
    aiuto = strcat(aiuto,'R - Apri ultima immagine\n');
    aiuto = strcat(aiuto,'S - Segna area da ritagliare\n');
    aiuto = strcat(aiuto,'T - Questo messaggio\n');
    aiuto = strcat(aiuto,'X - Salva dati su disco\n');
    aiuto = strcat(aiuto,'123456789 - Pulsanti etichettatura\n');
    msgbox(sprintf(aiuto),'Tasti rapidi');
end
