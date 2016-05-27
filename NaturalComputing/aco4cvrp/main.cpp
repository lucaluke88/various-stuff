#include "aco.h"
#include <math.h>

int main()
{
    printLogo();
    printf("MODALITA' DI TEST\n");

    // CONFIGURAZIONE PARAMETRI DI ESECUZIONE
    ACOVARS.verbose = 0;
    ACOVARS.sizeMetaPopolazione = 5;
    ACOVARS.qzero = 75;
    ACOVARS.useLocalSearch = 0;
    ACOVARS.showTours = 0;

    bool faiTest = 1;
    // AGGIORNA L'INDIVIDUO I NELLA POPOLAZIONE DI SOLUZIONI SE E SOLO SE L'ANT I HA FORNITO UN PERCORSO MENO COSTOSO
    bool aggiornaSoloSeNuovoCostoInferioreAlVecchio = 1;
    uint16_t nGenerazioni = 0, costoMiglioreSolPrecedente = 0;
    uint16_t nTentativiMiglioramento = ACOVARS.tentativiMiglioramento;
    uint16_t nVertici, nAnt, capacita, solPeggioreInit, solMiglioreInit, runSolMigliore = 0, solMiglioreAssoluto = numeric_limits<uint16_t>::max(), runSolMiglioreAssoluto = 0;
    ACOVARS.grafoFile = readIntFromConsole(string("[0] Crea grafo casuale\n[1] Leggi grafo da file\n>> "));
    string filenameLeggi = "";
    if(ACOVARS.grafoFile)
        filenameLeggi = readStringFromConsole(string("Nome del file: "));

    // input della capacità
    ostringstream vertRequest, antRequest, capRequest;
    vertRequest << "Numero vertici [DEFAULT " << ACOVARS.nVertici << "]: ";
    antRequest << "Numero ant [DEFAULT " << ACOVARS.nAnt << "]: ";
    nVertici = getNumberFromConsole(vertRequest.str(),'u');
    nAnt = getNumberFromConsole(antRequest.str(),'u');
    if(nVertici > 0) ACOVARS.nVertici = nVertici;
    if(nAnt > 0) ACOVARS.nAnt = nAnt;

    // ALLOCAZIONE STRUTTURE DATI
    vectorUint richieste(ACOVARS.nVertici); // ARRAY RICHIESTE CLIENTI
    matrixUint pesoArchi(ACOVARS.nVertici, vectorUint(ACOVARS.nVertici));  // MATRICE PESI
    matrixDouble feromoneArchi(ACOVARS.nVertici, vector<double>(ACOVARS.nVertici)); // MATRICE FEROMONE
    matrixUint popolazioneSoluzioni(ACOVARS.nAnt); // POPOLAZIONE SOLUZIONI
    matrixUint popolazioneSoluzioniInit(ACOVARS.nAnt);  // PER RESET
    vectorUint costoSoluzioni(ACOVARS.nAnt); // CACHE COSTO SOLUZIONI
    vectorUint costoSoluzioniInit(ACOVARS.nAnt);    // PER RESET
    AntType coloniaAnt[ACOVARS.nAnt]; // COLONIA ANT

    // MATRICE DELLE DESIDERABILITÀ DEI VERTICI
    for(uint16_t i=0; i<ACOVARS.nAnt; i++)
    {
        for(uint16_t j=0; j<ACOVARS.nVertici; j++)
        {
            desiderabilitaType tmp;
            tmp.vertice = i;
            tmp.value = 0;
            coloniaAnt[i].desiderabilitaVertici.push_back(tmp);
            coloniaAnt[i].flagVerticiVisitati.push_back(0);
        }
    }

    // Inizializzazione strutture dati --------------------------------------
    if(ACOVARS.grafoFile)
    {
        leggiGrafo(filenameLeggi,richieste, pesoArchi, feromoneArchi);
    }
    else
    {
        creaGrafoCasuale(richieste, pesoArchi, feromoneArchi);
        if(readIntFromConsole(string("[0] Non salvare il grafo\n[1] Salva il grafo con nome\n>> ")))
        {
            string filename = readStringFromConsole(string("Nome del file: "));
            salva(filename,richieste,pesoArchi);
        }
    }

    uint16_t tspCapacita = accumulate(richieste.begin(),richieste.end(),0);
    // input della capacità
    capRequest << "Capacita' [DEFAULT " << ACOVARS.maxRichiesta << "][TSP: >=" << tspCapacita << "]: ";
    capacita = getNumberFromConsole(capRequest.str(),'u');

    if (capacita >= ACOVARS.maxRichiesta)
        ACOVARS.capacita = capacita;
    else
        ACOVARS.capacita = ACOVARS.maxRichiesta;

    // INIZIALIZZAZIONE PROPOSTE DI SOLUZIONI

    printf("Inizializzazione popolazione proposte di soluzione (%u candidati)\n",ACOVARS.nAnt);

    if(ACOVARS.useMultiThread)
        initPopolazioneSoluzioniMT(popolazioneSoluzioni, richieste,pesoArchi);
    else
        initPopolazioneSoluzioni(popolazioneSoluzioni, richieste,pesoArchi);

    uint16_t indextmp;
    updateCacheCostiSoluzioni(popolazioneSoluzioni,pesoArchi,costoSoluzioni,indextmp);
    solMiglioreInit = costoSoluzioni[indextmp];
    /* Aggiorno i valori da dare in report */
    indextmp = distance(costoSoluzioni.begin(),max_element(costoSoluzioni.begin(),costoSoluzioni.end()));
    solPeggioreInit = costoSoluzioni[indextmp];

    // Global update al passo 0 --------------------------------------
    printProposteSoluzioni(popolazioneSoluzioni, costoSoluzioni);
    uint16_t migliorSoluzione = distance(costoSoluzioni.begin(),min_element(costoSoluzioni.begin(),costoSoluzioni.end()));
    costoMiglioreSolPrecedente = costoSoluzioni[migliorSoluzione];
    globalUpdate(migliorSoluzione, costoSoluzioni, popolazioneSoluzioni, feromoneArchi);
    printf("\nIntervallo costo soluzioni in fase di init: (%u - %u), media: %f\n",solMiglioreInit,solPeggioreInit,mediaCosti(costoSoluzioni));

    // BACKUP ELEMENTI PER IL RESET
    {
        copiaVettore(costoSoluzioni,costoSoluzioniInit);
        for(uint16_t i=0; i<ACOVARS.nAnt; i++)
        {
            copiaVettore(popolazioneSoluzioni[i],popolazioneSoluzioniInit[i]);
        }
    }


    while(faiTest)
    {
        vectorUint minimiLocali;
        // INPUT DIMENSIONE DELLA METAPOPOLAZIONE, SCEGLI SE FARE RICERCA LOCALE O MENO
        {
            ACOVARS.sizeMetaPopolazione = readIntFromConsole(string("Dimensione della metapopolazione (0 per annullare la ricerca locale):  "));
            ACOVARS.useLocalSearch = (ACOVARS.sizeMetaPopolazione>0);

            if(ACOVARS.useLocalSearch)
                printf("TEST (Metapopolazione di %u soluzioni, %u ant) ----------\n",ACOVARS.sizeMetaPopolazione,ACOVARS.nAnt);
            else
                printf("TEST (No ricerca locale, %u ant) ----------\n",ACOVARS.nAnt);
        }

        time_t start = time(nullptr);
        while(nGenerazioni<ACOVARS.maxGenerazioni)
        {
            for(uint16_t i=0; i<ACOVARS.nAnt; i++)
            {
                if(ACOVARS.verbose) printf("ANT WALK PER ANT %u ******************\n",i);
                antWalk(coloniaAnt[i],pesoArchi, feromoneArchi, richieste);

                if(aggiornaSoloSeNuovoCostoInferioreAlVecchio)
                {
                    // IL TOUR DELL'ANT DIVENTA UNA PROPOSTA DI SOLUZIONE SOLO SE HA DIMINUITO IL COSTO
                    if(costoTour(coloniaAnt[i].tour,pesoArchi)<costoSoluzioni[i])
                        copiaVettore(coloniaAnt[i].tour,popolazioneSoluzioni[i]);
                }
                else
                {
                    //  AGGIORNA A PRESCINDERE
                    copiaVettore(coloniaAnt[i].tour,popolazioneSoluzioni[i]);
                }
            }
            // AGGIORNO I COSTI
            updateCacheCostiSoluzioni(popolazioneSoluzioni,pesoArchi,costoSoluzioni,migliorSoluzione);
            // RICERCA LOCALE
            if(ACOVARS.useLocalSearch)
            {
                localSearch(popolazioneSoluzioni,migliorSoluzione,pesoArchi,richieste,costoSoluzioni);
                updateCacheCostiSoluzioni(popolazioneSoluzioni,pesoArchi,costoSoluzioni,migliorSoluzione);
            }
            // GLOBAL UPDATE
            globalUpdate(migliorSoluzione,costoSoluzioni, popolazioneSoluzioni, feromoneArchi);

            if(costoSoluzioni[migliorSoluzione]<solMiglioreAssoluto)
            {
                solMiglioreAssoluto = costoSoluzioni[migliorSoluzione];
                runSolMiglioreAssoluto = nGenerazioni;
            }

            printf("GENERAZIONE %u: La migliore soluzione corrente ora ha costo %u, media %f\n",nGenerazioni,costoSoluzioni[migliorSoluzione],mediaCosti(costoSoluzioni));

            if(costoSoluzioni[migliorSoluzione] < costoMiglioreSolPrecedente) // HO MIGLIORATO, NO STAGNATION
            {
                printf("Costo migliore ora %u, Costo migliore precedente %u (ho migliorato)\n",costoSoluzioni[migliorSoluzione],costoMiglioreSolPrecedente);
                nTentativiMiglioramento = ACOVARS.tentativiMiglioramento;
                costoMiglioreSolPrecedente = costoSoluzioni[migliorSoluzione];
                runSolMigliore = nGenerazioni;
            }
            else if(costoSoluzioni[migliorSoluzione] > costoMiglioreSolPrecedente) // NON HO MIGLIORATO, NO STAGNATION
            {
                printf("Costo migliore ora %u, Costo migliore precedente %u (non ho migliorato)\n",costoSoluzioni[migliorSoluzione],costoMiglioreSolPrecedente);
                nTentativiMiglioramento = ACOVARS.tentativiMiglioramento;
            }
            else if(costoSoluzioni[migliorSoluzione] == costoMiglioreSolPrecedente && nTentativiMiglioramento == 0) // NON HO MIGLIORATO E HO ESAURITO I TENTATIVI
            {
                printf("Rischio di stagnation! ");
                if(minimiLocali.empty())
                    minimiLocali.push_back(costoSoluzioni[migliorSoluzione]);
                else if(minimiLocali.back()!=costoSoluzioni[migliorSoluzione])
                    minimiLocali.push_back(costoSoluzioni[migliorSoluzione]);

                {
                    nTentativiMiglioramento = ACOVARS.tentativiMiglioramento;
                    bool condizione = uint16_t(mediaCosti(costoSoluzioni)) == costoSoluzioni[migliorSoluzione];
                    if(condizione) // TUTTE LE SOLUZIONI SONO UGUALI COME COSTO AL MINIMO
                    {
                        initPopolazioneSoluzioni(popolazioneSoluzioni,richieste,pesoArchi);
                    }

                    else
                    {
                        printf("Reinizializzo gli individui: ");
                        for(uint16_t i=0;i<ACOVARS.nAnt;i++)
                        {
                            if(costoSoluzioni[i]==costoSoluzioni[migliorSoluzione])
                            {
                                printf("%u-",i);
                                resetFeromoneSoluzione(feromoneArchi,popolazioneSoluzioni[i]);
                                initIndividuo(i,popolazioneSoluzioni,richieste,pesoArchi); // LAVORIAMO SU ALTRI INDIVIDUI DELLA POP.
                                // local update come se fosse stato inserito da un'ant
                                for(uint16_t j=1;j<popolazioneSoluzioni[i].size();j++)
                                {
                                    uint16_t origine = popolazioneSoluzioni[i][j-1];
                                    uint16_t destinazione = popolazioneSoluzioni[i][j];
                                    feromoneArchi[origine][destinazione] = (1-ACOVARS.theta) * feromoneArchi[origine][destinazione] + ACOVARS.theta * ACOVARS.feromoneIniziale;
                                }
                            }
                        }
                        printf(" il cui costo e' pari al minimo locale\n");
                    }

                    updateCacheCostiSoluzioni(popolazioneSoluzioni,pesoArchi,costoSoluzioni,migliorSoluzione);
                    globalUpdate(migliorSoluzione, costoSoluzioni, popolazioneSoluzioni, feromoneArchi);
                    costoMiglioreSolPrecedente = costoSoluzioni[migliorSoluzione];
                }
            }
            else if(costoSoluzioni[migliorSoluzione] == costoMiglioreSolPrecedente && nTentativiMiglioramento > 0) // NON HO MIGLIORATO E HO ESAURITO I TENTATIVI// NON HO MIGLIORATO, MA HO ANCORA TENTATIVI
            {
                --nTentativiMiglioramento; // la soluzione non è migliorata
            }
            ++nGenerazioni;

            if(nGenerazioni==ACOVARS.maxGenerazioni)
            {
                printf("Hai esaurito le generazioni! Se vuoi puoi continuare con le iterazioni.\n");
                uint16_t nGenAggiuntive = readIntFromConsole(string("Continua per altre N generazioni [0 per concludere]: "));
                nGenerazioni += nGenAggiuntive;
            }
        }

        double tasktime = difftime( time(nullptr), start);

        // STAMPA INFORMAZIONI A SCHERMO
        {
            printf("Tempo di esecuzione: %f\n",tasktime);
            printf("Soluzione migliore in assoluto (costo %u):\n",solMiglioreAssoluto);
            if(ACOVARS.showTours) printTour(popolazioneSoluzioni[migliorSoluzione]);
            printf(" (run %u)\n",runSolMiglioreAssoluto);
            printf("Minimi locali:");
            printTour(minimiLocali);
            printf("\n");
        }

        // reset per un nuovo test ----------------------------------------------------
        {
            copiaVettore(costoSoluzioniInit,costoSoluzioni);
            for(uint16_t i=0; i<ACOVARS.nAnt; i++)
            {
                copiaVettore(popolazioneSoluzioniInit[i],popolazioneSoluzioni[i]);
            }

            resetFeromoneGrafo(feromoneArchi);
            migliorSoluzione = distance(costoSoluzioni.begin(),min_element(costoSoluzioni.begin(),costoSoluzioni.end()));
            costoMiglioreSolPrecedente = costoSoluzioni[migliorSoluzione];
            globalUpdate(migliorSoluzione, costoSoluzioni, popolazioneSoluzioni, feromoneArchi);
            nGenerazioni = runSolMigliore = 0;
            nTentativiMiglioramento = 20;
            solMiglioreAssoluto = numeric_limits<uint16_t>::max();
            runSolMiglioreAssoluto = 0;
        }

        faiTest = readIntFromConsole(string("[0] ESCI\n[1] CONTINUA \n>> "));
    }
}
