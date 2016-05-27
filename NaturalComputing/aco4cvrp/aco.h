#ifndef ACO_H
#define ACO_H

#include "utils.h"

uint16_t costoTour(vectorUint &tour, matrixUint &pesoArchi)
{
	uint16_t costoSoluzione = 0;
	for(uint16_t j=0; j<tour.size()-1; j++)
	{
		uint16_t origine = tour[j];
		uint16_t destinazione = tour[j+1];
		costoSoluzione += pesoArchi[origine][destinazione];
	}
	return costoSoluzione;
}

double getIncrementoFeromone(const uint16_t &orig, const uint16_t &dest, matrixUint &popolazioneSoluzioni)
{
	double incr = 0;
	for(uint16_t i=0; i<popolazioneSoluzioni.size(); i++) // scorro
	{
		uint16_t L = popolazioneSoluzioni[i].size();
		for(uint16_t j=0; j<L-1; j++)
		{
			if(popolazioneSoluzioni[i][j]==orig && popolazioneSoluzioni[i][j+1]==dest)
			{
				incr += (double) ACOVARS.Q / L;
			}
		}
	}
	return incr;
}

void globalUpdate(uint16_t idSolMigliore, vectorUint &costoSoluzioni, matrixUint &popolazioneSoluzioni, matrixDouble &feromoneArchi)
{
	if(ACOVARS.verbose) printf("Soluzione migliore %u con costo %u\n",idSolMigliore,costoSoluzioni[idSolMigliore]);
	// Faccio depositare il feromone
	uint16_t psiSMsize = popolazioneSoluzioni[idSolMigliore].size();
	for(uint16_t j=0; j<psiSMsize-1; j++)
	{
		uint16_t origine = popolazioneSoluzioni[idSolMigliore][j];
		uint16_t destinazione = popolazioneSoluzioni[idSolMigliore][j+1];
		double fInc = getIncrementoFeromone(origine,destinazione,popolazioneSoluzioni);

		if(ACOVARS.verbose) printf("Feromone corrente su (%u,%u): %f\n ",origine,destinazione,feromoneArchi[origine][destinazione]);
		if(ACOVARS.verbose) printf("Formula del GlobalUpdate: (1-%f)*%f + %f*%f\n",ACOVARS.rho,feromoneArchi[origine][destinazione],ACOVARS.rho,fInc);
		double ferTMP = (1-ACOVARS.rho) * feromoneArchi[origine][destinazione] + ACOVARS.rho * fInc;
		if(ACOVARS.verbose) printf("Nuovo valore prima del fer. limiting: %f\n",ferTMP);
		// per non saturare troppo
		feromoneArchi[origine][destinazione] = min(ferTMP,ACOVARS.feromoneMassimo);
		// per non azzerare
		feromoneArchi[origine][destinazione] = max(feromoneArchi[origine][destinazione], ACOVARS.feromoneIniziale);
		if(ACOVARS.verbose) printf("Valore aggiornato: %f\n",feromoneArchi[origine][destinazione]);
	}
}

void updateCacheCostiSoluzioni(matrixUint &popolazioneSoluzioni,const matrixUint &pesoArchi,vectorUint &costoSoluzioni, uint16_t &migliorSoluzione)
{
	for(uint16_t i=0; i<popolazioneSoluzioni.size(); i++)
	{
		costoSoluzioni[i] = 0;
		// Caching costo soluzione appena generata
		for(uint16_t j=0; j<popolazioneSoluzioni[i].size()-1; j++)
		{
			uint16_t origine = popolazioneSoluzioni[i][j];
			uint16_t destinazione = popolazioneSoluzioni[i][j+1];
			costoSoluzioni[i] += pesoArchi[origine][destinazione];
		}
	}
	migliorSoluzione = distance(costoSoluzioni.begin(),min_element(costoSoluzioni.begin(),costoSoluzioni.end()));
}

void printProposteSoluzioni(matrixUint &popolazioneSoluzioni, vectorUint &costoSoluzioni)
{
	printf("Create le seguenti proposte di soluzioni:\n");
	for(uint16_t i=0; i<popolazioneSoluzioni.size(); i++)
	{
		printf("Proposta %u: ",i);
		if(ACOVARS.showTours)
        {
            for(uint16_t j=0; j<popolazioneSoluzioni[i].size(); j++)
            {
                printf("%u-",popolazioneSoluzioni[i][j]);
            }

        }
		printf(", di costo %u\n",costoSoluzioni[i]);
	}
}

void printTour(vectorUint &tour)
{
	for(uint16_t j=0; j<tour.size(); j++)
	{
		printf("%u-",tour[j]);
	}
}

//! Corregge soluzioni unfeasible
void fixSoluzione(vectorUint &tour, vectorUint &richieste)
{
	vectorUint tourFixato;
    uint16_t caricoTmp = 0;
    tourFixato.push_back(0);
    for(uint16_t i=0;i<tour.size();i++)
	{
		if(tour[i]!=0)
        {
        	if((caricoTmp + richieste[tour[i]])>ACOVARS.capacita)
			{
				tourFixato.push_back(0);
				tourFixato.push_back(tour[i]);
				caricoTmp = richieste[tour[i]]; // perchè prima l'abbiamo azzerato
			}
			else
			{
				tourFixato.push_back(tour[i]);
				caricoTmp += richieste[tour[i]]; // perchè prima l'abbiamo azzerato
			}
		}
	}

	if(tourFixato.back()!=0)
	{
		tourFixato.push_back(0);
	}
	copiaVettore(tourFixato,tour);
}

//! Se un tour è feasible per CVRP
bool isFeasible(vectorUint &tour, vectorUint &richieste)
{
	if(tour[0]>0) return 0;
	if(tour.back()>0) return 0;
	uint16_t caricoTmp = 0;
	for(uint16_t i=0; i<tour.size(); i++)
	{
		if(tour[i]==0) caricoTmp = 0;
		else
		{
			if((caricoTmp + richieste[tour[i]]) > ACOVARS.capacita)
				return 0;
			else
				caricoTmp += richieste[tour[i]];
		}
	}
	return 1;
}

//! Fa lo swap di due coppie di archi
vectorUint TwoOptSwap(const uint16_t &i, const uint16_t &k, vectorUint &tour)
{
	vectorUint new_tour(tour.size());
	// 1. take route[0] to route[i-1] and add them in order to new_route
	for(uint16_t c = 0; c <= i - 1; ++c )
		new_tour[c] = tour[c];
	// 2. take route[i] to route[k] and add them in reverse order to new_route
	int dec = 0;
	for (unsigned int c = i; c <= k; ++c , dec++ )
		new_tour[c] = tour[k - dec];
	// 3. take route[k+1] to end and add them in order to new_route
	for (unsigned int c = k + 1; c < tour.size(); ++c )
		new_tour[c] = tour[c];
	return new_tour;
}

//! Rimuove di volta in volta una coppia di archi e ne crea un'altra per vedere se il costo totale si abbassa
void twoOpt(uint16_t npassi, vectorUint &tour, matrixUint &pesoArchi, vectorUint &richieste)
{
	// repeat until no improvement is made
	uint16_t improve = 0;
	uint16_t best_distance = 0;
	// calcolo il costo corrente del tour
	for(uint16_t i=1; i<tour.size(); i++)
	{
		best_distance += pesoArchi[tour[i-1]][tour[i]];
	}

	while ( improve < npassi ) // 20 passi di miglioramenti
	{
		for(uint16_t i = 0; i < tour.size() - 1; i++ )
		{
			for(uint16_t k = i + 1; k < tour.size(); k++)
			{
				vectorUint new_tour = TwoOptSwap( i, k, tour );
				uint16_t new_distance = 0;
				for(uint16_t i=1; i<new_tour.size(); i++)
				{
					new_distance += pesoArchi[new_tour[i-1]][new_tour[i]];
				}
				if ((new_distance < best_distance) && isFeasible(new_tour, richieste))
				{
					// Improvement found so reset
					improve = 0;
					copiaVettore(new_tour,tour);
					best_distance = new_distance;
				}
			}
		}
		++improve;
	}
}

//! Inizializza un individuo in modo random
void initIndividuo(uint16_t i, matrixUint &popolazioneSoluzioni, vectorUint &richieste,matrixUint &pesoArchi)
{
	vector<uint16_t> tour( boost::counting_iterator<int>( 0 ),
	                       boost::counting_iterator<int>( ACOVARS.nVertici ) );
	struct timespec tm;
	clock_gettime( CLOCK_REALTIME, &tm);
	boost::mt19937 generator(tm.tv_nsec);
	boost::uniform_int<> uni_dist;
	boost::variate_generator<boost::mt19937&, boost::uniform_int<> > randomNumberBoost(generator, uni_dist);
	random_shuffle(tour.begin(), tour.end(),randomNumberBoost);
	bool faiTwoOpt = randomNumber(1,20)>10;
	if(faiTwoOpt)
	{
		uint16_t nTentativi = randomNumber(1,20);
		twoOpt(nTentativi,tour,pesoArchi,richieste);
	}
	if(!isFeasible(tour,richieste)) fixSoluzione(tour, richieste);
	copiaVettore(tour,popolazioneSoluzioni[i]);
}

//! Inizializza la popolazione allo step 0
void initPopolazioneSoluzioniMT(matrixUint &popolazioneSoluzioni, vectorUint &richieste,matrixUint &pesoArchi)
{
	printf("\n");
	for(uint16_t i=0; i<ACOVARS.nAnt; i++)
	{
		thread t(&initIndividuo,ref(i),ref(popolazioneSoluzioni), ref(richieste),ref(pesoArchi));
		t.join();
	}


}

//! Inizializza la popolazione allo step 0
void initPopolazioneSoluzioni(matrixUint &popolazioneSoluzioni, vectorUint &richieste,matrixUint &pesoArchi)
{
	debugPrint("\n");
	for(uint16_t i=0; i<ACOVARS.nAnt; i++)
	{
		if(ACOVARS.verbose)
			printf("Creazione soluzione random %u\n",i);
		vector<uint16_t> tour( boost::counting_iterator<int>( 0 ),
							   boost::counting_iterator<int>( ACOVARS.nVertici ) );
		struct timespec tm;
		clock_gettime( CLOCK_REALTIME, &tm);
		boost::mt19937 generator(tm.tv_nsec);
		boost::uniform_int<> uni_dist;
		boost::variate_generator<boost::mt19937&, boost::uniform_int<> > randomNumberBoost(generator, uni_dist);
		random_shuffle(tour.begin(), tour.end(),randomNumberBoost);
		uint16_t nTentativi = randomNumber(1,20);
		twoOpt(nTentativi,tour,pesoArchi,richieste);
		if(!isFeasible(tour,richieste)) fixSoluzione(tour, richieste);
		copiaVettore(tour,popolazioneSoluzioni[i]);
		if(ACOVARS.verbose)
		{
			printTour(popolazioneSoluzioni[i]);
			printf("\n");
		}
	}
}

//! Inizializza un grafo casuale
void creaGrafoCasuale(vectorUint &richieste, matrixUint &pesoArchi, matrixDouble &feromoneArchi)
{
	for(uint16_t i = 0; i < ACOVARS.nVertici ; i++)
	{
		// Generazione casuale delle richieste
		if(i>0)
			richieste[i] = randomNumber(ACOVARS.minRichiesta,ACOVARS.maxRichiesta);
		else
			richieste[i] = 0;
		//if(ACOVARS.verbose)
		printf("Assegnata richiesta %u al vertice %u\n",richieste[i],i);

		for(uint16_t j = 0; j < ACOVARS.nVertici ; j++)
		{
			if(i==j) // feromone nullo e peso massimo, così i cappi non verranno mai selezionati
			{
				pesoArchi[i][j] = numeric_limits<uint16_t>::max();
				feromoneArchi[i][j] = 0;
			}
			else
			{
				pesoArchi[i][j] = randomNumber(ACOVARS.minRichiesta,ACOVARS.maxRichiesta);
				feromoneArchi[i][j] = ACOVARS.feromoneIniziale;
			}

			if(ACOVARS.verbose)
				printf("Assegnato peso %u e feromone %f all'arco (%u,%u)\n",pesoArchi[i][j],feromoneArchi[i][j],i,j);
		}
	}
}

//! Is the heuristic of Savings where f and g are two parameters.
double savings(const uint16_t i, const uint16_t j, matrixUint &pesoArchi)
{
	uint16_t dist_i_zero = /*(i!=0)?*/pesoArchi[i][0]/*:numeric_limits<uint16_t>::max()*/;
	uint16_t dist_zero_j = /*(j!=0)?*/pesoArchi[0][j]/*:numeric_limits<uint16_t>::max()*/;
	uint16_t 	dist_i_j = /*(i!=j)?*/pesoArchi[i][j]/*:numeric_limits<uint16_t>::max()*/;
	return (double) (dist_i_zero + dist_zero_j - ACOVARS.g * dist_i_j + ACOVARS.f * abs(dist_i_zero - dist_zero_j));
}

void BubbleSort(vector<desiderabilitaType> &desiderabilita)
{
	/* elemN è il numero degli elementi del vettore da ordinare */
	uint16_t elemN = desiderabilita.size();
	uint16_t alto;
	for (alto = elemN - 1; alto > 0; alto-- )
	{
		for (int i=0; i<alto; i++)
		{
			if (desiderabilita[i].value>desiderabilita[i+1].value)
			{
				double valueTmp = desiderabilita[i].value;
				uint16_t verticeTmp = desiderabilita[i].vertice;

				desiderabilita[i].value = desiderabilita[i+1].value;
				desiderabilita[i].vertice = desiderabilita[i+1].vertice;

				desiderabilita[i+1].value = valueTmp;
				desiderabilita[i+1].vertice = verticeTmp;

			}
		}
	}
}


uint16_t buildDesiderabilita(AntType &ant, vector<desiderabilitaType> &desiderabilita, matrixUint &pesoArchi, matrixDouble &feromoneArchi, vectorUint &richieste)
{
	uint16_t bestVicino = 0;
	double bestValue = 0;

	uint16_t pred = ant.tour.back(); // riferimento  all'ultimo vertice inserito nel tour
	double desiderabilitaSum = 0;	// mi serve per la fase di exploration
	for(uint16_t i=0; i<ant.flagVerticiVisitati.size(); i++)
	{
		// CALCOLO LA DESIDERABILITÀ
		double value;
		// SE CAPPIO O GIÀ VISITATO
		if(pred==i || ant.flagVerticiVisitati[i])
		{
			value = 0;
		}
		// SE SUPERA LA CAPACITÀ
		else if(ant.caricoCorrente+richieste[i] > ACOVARS.capacita)
		{
			value = 0;
		}
		else
		{
			// INFLUENZA FEROMONE
			double feromone = (double) feromoneArchi[pred][i];
			double influenza_feromone = pow(feromone,ACOVARS.alfa);
			if(ACOVARS.verbose) printf("Feromone (%u,%u): %f -> Influenza: %f\n",pred,i,feromone,influenza_feromone);
			// INFLUENZA DISTANZA/PESO
			uint16_t peso = pesoArchi[pred][i];
			double influenza_distanza = (double) pow((double) 1/peso,ACOVARS.beta);
			if(ACOVARS.verbose) printf("Peso (%u,%u): %u -> Influenza: %f\n",pred,i,peso,influenza_distanza);
			// INFLUENZA SAVINGS
			double savValue = savings(pred,i,pesoArchi);
			double influenza_savings = (double) pow(savValue,ACOVARS.lambda);
			if(ACOVARS.verbose) printf("Savings (%u,%u): %f -> Influenza: %f\n",pred,i,savValue,influenza_savings);
			value = influenza_feromone + influenza_distanza + influenza_savings;
		}
		// COPIO NELL'ARRAY I VALORI AGGIORNATI DI DESIDERABILITÀ
		desiderabilita[i].value = value;
		desiderabilita[i].vertice = i;
		// Aggiorno il miglior valore corrente
		if(value>bestValue)
		{
			bestVicino = i;
			bestValue = value;
		}
		desiderabilitaSum += desiderabilita[i].value;
	}
	// ordino i vettori per desiderabilità
	BubbleSort(desiderabilita); // ordino l'array in ordine crescente di valore senza perdere i riferimenti ai vertici
	// Normalizzo i valori
	for(uint16_t i=0; i<desiderabilita.size(); i++)
	{
		desiderabilita[i].value = (double) (desiderabilita[i].value / desiderabilitaSum)*100;
		if(ACOVARS.verbose) printf("Desiderabilita del vertice %u = %f\n",desiderabilita[i].vertice,desiderabilita[i].value);
	}
	return bestVicino;
}

uint16_t getProssimoVertice(AntType &ant, matrixUint &pesoArchi, matrixDouble &feromoneArchi, vectorUint &richieste)
{
	// l'ant decide il prossimo vicino in modo o probabilistico o in modo determininistico
	uint16_t q = randomNumber(1,100);
	// Costruisco la desiderabilità dei vicini
	uint16_t bestVicino = buildDesiderabilita(ant, ant.desiderabilitaVertici, pesoArchi, feromoneArchi,richieste);

	if(q<= ACOVARS.qzero)
	{
		debugPrint("Vado di Exploitation \n");
		// vado di exploitation, restituisco il miglior vicino per distanza, feromone e savings
		return bestVicino;
	}
	else
	{
		debugPrint("Vado di Exploration \n");
		// vado di exploration, ogni vertice non visitato ha una possibilità di essere scelto come prossimo vertice
		bestVicino = randomNumber(1,100);
		for(uint16_t i=0; i<ant.desiderabilitaVertici.size()-1; i++)
		{
			if(bestVicino<ant.desiderabilitaVertici[i].value)
				return ant.desiderabilitaVertici[i].vertice;
		}
		return ant.desiderabilitaVertici[ant.desiderabilitaVertici.size()-1].vertice;
	}
}

bool isOne(uint16_t i)
{
    return i == 1;
}

void antWalk(AntType &ant, matrixUint &pesoArchi, matrixDouble &feromoneArchi, vectorUint &richieste)
{
	// Cancello il vecchio tour
	ant.tour.erase(ant.tour.begin(),ant.tour.end()); // cancello il vecchio tour
	// Cancello i flag dei vertici visitati prima
	fill(ant.flagVerticiVisitati.begin(), ant.flagVerticiVisitati.end(), 0);
	// L'ant parte dalla sorgente
	ant.tour.push_back(0);
	while(count_if(ant.flagVerticiVisitati.begin(), ant.flagVerticiVisitati.end(), isOne) < ACOVARS.nVertici-1) // la sorgente non viene inserita tra i vertici visitati
	{
		uint16_t vicino = getProssimoVertice(ant,pesoArchi,feromoneArchi,richieste);
		//if(vicino!=ant.tour.back())
		{
			// LOCAL UPDATE
			if(ACOVARS.verbose)
					printf("Local Update (1-%f)*%f + %f*%f = ",ACOVARS.theta,feromoneArchi[ant.tour.back()][0],ACOVARS.theta,ACOVARS.feromoneIniziale);
			feromoneArchi[ant.tour.back()][0] = (1-ACOVARS.theta) * feromoneArchi[ant.tour.back()][0] + ACOVARS.theta * ACOVARS.feromoneIniziale;

			if(ACOVARS.verbose) printf("%f\n",feromoneArchi[ant.tour.back()][0]);

			// INSERISCO VICINO
			ant.caricoCorrente += richieste[vicino];
			ant.tour.push_back(vicino);

			if(ACOVARS.verbose)
					printf("Vicino %u inserito nel tour\n",vicino);
			if(vicino!=0)
				ant.flagVerticiVisitati[vicino] = 1;
			else
				ant.caricoCorrente = 0;
		}
	}
	fixSoluzione(ant.tour,richieste);
}

void displacementMT(vectorUint &tour, vectorUint &dispTour, uint16_t index, uint16_t lenght)
{
	copiaVettore(tour,dispTour);
	vectorUint subVector(lenght);
	uint16_t fine = index+lenght-1;
	copy(dispTour.begin()+index,dispTour.begin()+fine,subVector.begin());
	dispTour.erase(dispTour.begin()+index,dispTour.begin()+fine);
	for(uint16_t i=0; i<lenght; i++)
	{
		dispTour.push_back(subVector[i]);
	}
}

void aggiornaPopolazione(matrixUint &popolazioneSoluzioni, matrixUint &metaPopolazione, matrixUint &pesoArchi, vectorUint &costiSoluzione)
{
	vectorUint costiSoluzioneAux;
	if(ACOVARS.verbose) printf("Aggiungo costi pop principale\n");
	for(uint16_t i=0; i<popolazioneSoluzioni.size(); i++)
	{
		uint16_t costo = 0;
		for(uint16_t j=1; j<popolazioneSoluzioni[i].size(); j++)
		{
			uint16_t origine = popolazioneSoluzioni[i][j-1];
			uint16_t destinazione = popolazioneSoluzioni[i][j];
			costo += pesoArchi[origine][destinazione];
		}
		costiSoluzioneAux.push_back(costo);
	}
	debugPrint("Aggiungo costi pop secondaria\n");
	for(uint16_t i=0; i<metaPopolazione.size(); i++)
	{
		uint16_t costo = 0;
		for(uint16_t j=1; j<metaPopolazione[i].size(); j++)
		{
			uint16_t origine = metaPopolazione[i][j-1];
			uint16_t destinazione = metaPopolazione[i][j];
			costo += pesoArchi[origine][destinazione];
		}
		costiSoluzioneAux.push_back(costo);
	}
	// Creazione nuova popolazione
	debugPrint("Creo nuova popolazione\n");
	matrixUint nuovaPopolazione(popolazioneSoluzioni.size(), vectorUint(popolazioneSoluzioni.size()));
	for(uint16_t i=0; i<popolazioneSoluzioni.size(); i++)
	{
		uint16_t currentMin = distance(costiSoluzioneAux.begin(),min_element(costiSoluzioneAux.begin(),costiSoluzioneAux.end()));
		if(currentMin>=popolazioneSoluzioni.size())
		{
			copiaVettore(metaPopolazione[currentMin - popolazioneSoluzioni.size()], nuovaPopolazione[i]);
		}
		else
			copiaVettore(popolazioneSoluzioni[currentMin], nuovaPopolazione[i]);
		costiSoluzioneAux[currentMin] = numeric_limits<uint16_t>::max();
	}

	// P <- nuovaPop
	for(uint16_t i=0; i<popolazioneSoluzioni.size(); i++)
	{
		copiaVettore(nuovaPopolazione[i],popolazioneSoluzioni[i]);
		//printTour(popolazioneSoluzioni[i]);

		uint16_t costo = 0;
		for(uint16_t j=1; j<popolazioneSoluzioni[i].size(); j++)
		{
			uint16_t origine = popolazioneSoluzioni[i][j-1];
			uint16_t destinazione = popolazioneSoluzioni[i][j];
			costo += pesoArchi[origine][destinazione];
		}
		costiSoluzione[i] = costo;
		//printf(" di costo %u\n",costiSoluzione[i]);
	}
}

void randomShuffle(vectorUint &tour,uint16_t inizio, uint16_t fine)
{
	struct timespec tm;
	clock_gettime( CLOCK_REALTIME, &tm);
	boost::mt19937 generator(tm.tv_nsec);
	boost::uniform_int<> uni_dist;
	boost::variate_generator<boost::mt19937&, boost::uniform_int<> > randomNumber(generator, uni_dist);
	random_shuffle(tour.begin()+inizio, tour.begin()+fine,randomNumber);
}

void localSearch(matrixUint &popolazioneSoluzioni, uint16_t idBestSol, matrixUint &pesoArchi, vectorUint &richieste, vectorUint &costiSoluzione)
{
	if(ACOVARS.verbose) printf("Local search\n");
	// operatori di muta
	matrixUint metaPopolazione(ACOVARS.sizeMetaPopolazione, vectorUint(ACOVARS.sizeMetaPopolazione));
	for(uint16_t i=0; i<ACOVARS.sizeMetaPopolazione; i++)
	{
		uint16_t metodo = randomNumber(1,6);
		switch(metodo)
		{
			case(1): // DisplacementMT
			{
				bool creazione_riuscita = 0;
				vectorUint dispTour(popolazioneSoluzioni[idBestSol].size());
				try
				{
					uint16_t index = randomNumber(1,(uint16_t)dispTour.size()/2);
					uint16_t length = randomNumber(1,dispTour.size()-index);
					displacementMT(popolazioneSoluzioni[idBestSol],dispTour,index,length);
					creazione_riuscita = dispTour.size()>0;
				}
				catch( int e1 )
				{
					printf("Errore creazione tour DisplacementMT\n");
				}
				if(creazione_riuscita) copiaVettore(dispTour,metaPopolazione[i]);
				else printf("Errore creazione tour DisplacementMT\n");
			}
			case(2): // 2Opt
			{
				bool creazione_riuscita = 0;
				vectorUint twoOptTour(popolazioneSoluzioni[idBestSol].size());
				try
				{
					copiaVettore(popolazioneSoluzioni[idBestSol],twoOptTour);
					uint16_t nTentativi = randomNumber(1,20);
					twoOpt(nTentativi, twoOptTour, pesoArchi, richieste);
					creazione_riuscita = twoOptTour.size()>0;
				}
				catch( int e1 )
				{
					printf("Errore creazione tour RandomSh\n");
				}
				if(creazione_riuscita) copiaVettore(twoOptTour,metaPopolazione[i]);
				else printf("Errore creazione tour twoOptTour\n");
			}
			case(3): // RandomShuffle
			{
				bool creazione_riuscita = 0;
				vectorUint randomShTour(popolazioneSoluzioni[idBestSol].size());
				try
				{
					copiaVettore(popolazioneSoluzioni[idBestSol],randomShTour);
					uint16_t inizio = randomNumber(1,(uint16_t)randomShTour.size()/2);
					uint16_t fine = randomNumber(inizio+1,randomShTour.size());
					randomShuffle(randomShTour,inizio,fine);
					creazione_riuscita = randomShTour.size()>0;
				}
				catch( int e1 )
				{
					printf("Errore creazione tour RandomSh\n");
				}
				if(creazione_riuscita) copiaVettore(randomShTour,metaPopolazione[i]);
				else printf("Errore creazione tour RandomShuffle\n");
			}
			case(4): // RandomSwap di sottosequenze
			{
				bool creazione_riuscita = 0;
				vectorUint randomShTour(popolazioneSoluzioni[idBestSol].size());
				try
				{
					copiaVettore(popolazioneSoluzioni[idBestSol],randomShTour);
					subSeqSwap(randomShTour, uint16_t(2), uint16_t(7), uint16_t(3));
					creazione_riuscita = randomShTour.size()>0;
				}
				catch( int e1 )
				{
					printf("Errore creazione tour RandomSh\n");
				}
				if(creazione_riuscita) copiaVettore(randomShTour,metaPopolazione[i]);
				else printf("Errore creazione tour RandomSh\n");
			}
			case(5): // Combino 1 e 2
			{
				bool creazione_riuscita = 0;
				vectorUint dispOptTour(popolazioneSoluzioni[idBestSol].size());
				try
				{
					uint16_t index = randomNumber(1,(uint16_t) dispOptTour.size()/2);
					uint16_t length = randomNumber(1,dispOptTour.size()-index);
					displacementMT(popolazioneSoluzioni[idBestSol],dispOptTour,index,length);
					uint16_t nTentativi = randomNumber(1,20);
					twoOpt(nTentativi, dispOptTour, pesoArchi, richieste);
					creazione_riuscita = dispOptTour.size()>0;
				}
				catch( int e1 )
				{
					printf("Errore creazione tour dispOptTour\n");
				}
				if(creazione_riuscita) copiaVettore(dispOptTour,metaPopolazione[i]);
				else printf("Errore creazione tour dispOptTour\n");
			}
			case(6): // Combino 3 e 2
			{
				bool creazione_riuscita = 0;
				vectorUint randomShOptTour(popolazioneSoluzioni[idBestSol].size());
				try
				{
					copiaVettore(popolazioneSoluzioni[idBestSol],randomShOptTour);
					uint16_t inizio = randomNumber(1,(uint16_t)randomShOptTour.size()/2);
					uint16_t fine = randomNumber(inizio+1,randomShOptTour.size());
					randomShuffle(randomShOptTour,inizio,fine);
					uint16_t nTentativi = randomNumber(1,20);
					twoOpt(nTentativi,randomShOptTour, pesoArchi, richieste);
					creazione_riuscita = randomShOptTour.size()>0;
				}
				catch( int e1 )
				{
					printf("Errore creazione tour case(6)\n");
				}
				if(creazione_riuscita) copiaVettore(randomShOptTour,metaPopolazione[i]);
				else printf("Errore creazione tour randomShOptTour\n");
			}


		}
	}
	// Aggiorniamo P <-- P U MetaPop
	// correggo la metapopolazione (vincoli di CVRP)

	for(uint16_t i=0;i<metaPopolazione.size();i++)
	{
        fixSoluzione(metaPopolazione[i],richieste);
	}

	aggiornaPopolazione(popolazioneSoluzioni, metaPopolazione,pesoArchi,costiSoluzione);
}

//! Inizializza un grafo casuale
void leggiGrafo(string filename, vectorUint &richieste, matrixUint &pesoArchi, matrixDouble &feromoneArchi)
{
	vectorString fileContent = readFile(filename);
	string* tmptokens;
	tmptokens = string_split(fileContent[0],":");
	ACOVARS.nVertici = stringToInt(tmptokens[1]);
	if(ACOVARS.verbose) cout << "Leggo " << ACOVARS.nVertici << " vertici\n";
	ACOVARS.maxRichiesta = 0;

	// -------------------------------------------
	for(uint16_t i=2; i<2+ACOVARS.nVertici; i++)
	{
		tmptokens = string_split(fileContent[i],",");
		uint16_t domanda = stringToInt(tmptokens[1]);
		ACOVARS.maxRichiesta = max(ACOVARS.maxRichiesta,domanda);
		richieste[i-2] = domanda;
		if(ACOVARS.verbose)
			printf("Assegnata richiesta %u al vertice %u\n",richieste[i-2],i-2);
	}

	ACOVARS.maxPeso = 0;

	for(uint16_t k=0; k<=pow(ACOVARS.nVertici,2); k++)
	{
		tmptokens = string_split(fileContent[2+ACOVARS.nVertici+k],",");
		uint16_t i = stringToInt(tmptokens[0]);
		uint16_t j = stringToInt(tmptokens[1]);
		uint16_t p = stringToInt(tmptokens[2]);
		ACOVARS.maxPeso = max(p,ACOVARS.maxPeso);
		if(i==j) // feromone nullo e peso massimo, così i cappi non verranno mai selezionati
		{
			pesoArchi[i][j] = numeric_limits<uint16_t>::max();
			feromoneArchi[i][j] = 0;
		}
		else
		{
			pesoArchi[i][j] = p;
			feromoneArchi[i][j] = ACOVARS.feromoneIniziale;
		}
		if(ACOVARS.verbose)
			printf("Assegnato peso %u all'arco %u,%u\n",pesoArchi[i][j],i,j);
	}
}

//! Esporta il grafo in un file di testo nella cartella corrente
/*!	@param nome il nome del file (sarà seguito dai suffissi rispettivi)
 */
void salva(const string &nome, vectorUint &richieste, matrixUint &pesoArchi)
{
	std::ofstream a_file ( nome );
	a_file<<"NVERTICI:"<< ACOVARS.nVertici << "\n";
	a_file<<"VERTICI (id,domanda)\n";
	for(uint16_t i=0; i<ACOVARS.nVertici; i++)
		a_file<< i <<","<< richieste[i] <<"\n";
	a_file<<"ARCHI (id origine, id destinazione, peso)\n";
	for(uint16_t i=0; i<ACOVARS.nVertici; i++)
	{
		for(uint16_t j=0; j<ACOVARS.nVertici; j++)
		{
			a_file<<	i;
			a_file<<	",";
			a_file<<	j;
			a_file<<	",";
			a_file<<	pesoArchi[i][j]<<"\n";
		}
	}
	a_file.close();
}

void resetFeromoneSoluzione(matrixDouble &feromoneArchi, vectorUint &soluzione)
{
    for(uint16_t j=1; j<soluzione.size(); j++)
    {
        feromoneArchi[soluzione[j-1]][soluzione[j]] = ACOVARS.feromoneIniziale;
	}
}


void resetFeromoneGrafo(matrixDouble &feromoneArchi)
{
    for(uint16_t i=0;i<ACOVARS.nVertici;i++)
	{
		for(uint16_t j=0;j<ACOVARS.nVertici;j++)
		{
            if(i==j)
			{
                feromoneArchi[i][j] = numeric_limits<uint16_t>::max();
			}
			else
			{
				feromoneArchi[i][j] = ACOVARS.feromoneIniziale;
			}
		}
	}
}

#endif // ACO_H
