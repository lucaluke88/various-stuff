public class stringaGA
{
	/*  s
	 * Esempio molto semplice di un algoritmo genetico.
	 * Dato un insieme di stringhe binarie (dei numeri binari), vogliamo ottenere il massimo numero di 1 presenti.
	 * Per esempio, se ogni stringa fosse composta da 10 numeri, vorremmo ottenere 10 come massimo.
	 * Algoritmo genetico:
	 * inizializza_popolazione();
	 * per ogni generazione: 
	 * {
	 * 		scegli a due a due i genitori da far incrociare tramite una selezione a roulette
	 * 		fai il crossover tra i due genitori (in questo esempio, con un solo punto di taglio, a metà)
	 * 		ogni elemento della nuova popolazione subisce una mutazione puntuale (un solo bit casuale viene flippato)
	 * }
	 * Attuale punto debole: l'individuo ottimo viene "preservato" molto poco, perchè nella roulette ha poche possibilità 
	 * in più rispetto agli altri di essere selezionato. Questo porta a una non convergenza.
	 * Si dovrebbe potenziare il sistemi di premi e punizioni (modello elitista, in cui conserviamo i genitori migliori) 
	 * ma complicherei troppo questo codice di esempio.
	 */
	
	public static void main(String[] args)
	{
		int nGenerazioni = 5; // quante interazioni vogliamo
		int nIndividui = 6; // quanti individui (cromosomi) ha la nostra popolazione
		int sizeIndividui = 10; // ogni individuo quanti bit ha?
		
		// Creiamo la prima popolazione, o generazione 0
		int[][] popolazione = createPopulation(nIndividui,sizeIndividui);
		// Facciamo nGenerazioni iterazioni
		for (int i=0;i<nGenerazioni;i++)
		{
			// Selezione e crossover
			popolazione = evolviPopolazione(popolazione);
			// Mutazione dei nuovi individui
			popolazione = mutaIndividui(popolazione);
			
			System.out.println("Generazione "+(i+1)+", fMax attuale: "+maxFitness(popolazione)+" ------");
			for (int j=0;j<popolazione.length;j++)
				System.out.println("Individuo "+(j+1)+": "+arraytoString(popolazione[j])+" con fitness "+getFitness(popolazione[j]));
			
		}
	}

	private static int maxFitness(int[][] popolazione)
	{
		int maxFitness = 0;
		
		for (int j=0;j<popolazione.length;j++)
		{
			if(getFitness(popolazione[j])>maxFitness)
				maxFitness = getFitness(popolazione[j]);
		}
		return maxFitness;
	}

	private static int[][] mutaIndividui(int[][] popolazione)
	{
		int[][] new_pop = popolazione;
		// mutazione bit flip, un bit a caso in ogni individuo viene mutato
		for (int i=0;i<popolazione.length;i++)
		{
			int randomLocation = (int)Math.floor(Math.random()*new_pop[0].length);
			if(new_pop[i][randomLocation]==0)
				new_pop[i][randomLocation] = 1;
			else
				new_pop[i][randomLocation] = 0;
		}
		return new_pop;
	}

	private static int[][] evolviPopolazione(int[][] popolazione)
	{
		int nCrossovers = (int) Math.floor((popolazione.length)/2);
		int[][] nuova_popolazione = popolazione;
		for (int i=0;i<nCrossovers;i++)
		{
			int[][] coppiaIndividui = selezioneGenitori(popolazione);
			int[][] coppiaNuoviIndividui = crossover(coppiaIndividui);
			nuova_popolazione[i] = coppiaNuoviIndividui[0];
			nuova_popolazione[i+1] = coppiaNuoviIndividui[1];
		}
		return nuova_popolazione;
	}

	// seleziona due individui per il crossover con una roulette di probabilità
	private static int[][] selezioneGenitori(int[][] popolazione)
	{
		int[][] coppia = new int[2][popolazione[1].length];
		// fitness totale di questa generazione
		coppia[0] = scegliIndividuo(popolazione);
		//System.out.println("Genitore 1: "+arraytoString(coppia[0]));
		coppia[1] = scegliIndividuo(popolazione);
		//System.out.println("Genitore 2: "+arraytoString(coppia[1]));
		return coppia;
	}

	// effettua il crossover restituendo due nuovi individui
	private static int[][] crossover(int[][] coppia)
	{
		int nBit = coppia[0].length;
		/*
		 * FIGLIO1 = P1|P1|P1|P2|P2|P2
		 * FIGLIO2 = P2|P2|P2|P1|P1|P1
		 */
		int[][] figli = new int[2][nBit];
		int i=0;
		for (;i<Math.floor(nBit/2);i++)
		{
			figli[0][i] = coppia[0][i];
			figli[1][i] = coppia[1][i];
		}
		for (;i<nBit;i++)
		{
			figli[0][i] = coppia[1][i];
			figli[1][i] = coppia[0][i];
		}
		
		//System.out.println("Figlio 1: "+arraytoString(figli[0]));
		//System.out.println("Figlio 2: "+arraytoString(figli[1]));
		
		return figli;
	}

	// scegli candidato per il crossover
	private static int[] scegliIndividuo(int[][] popolazione)
	{
		int sumFitness = 0;
		for (int i=0;i<popolazione.length;i++)
			sumFitness += getFitness(popolazione[i]);
		// selezione casuale (roulette) del primo cromosoma
		int randomNumber = (int)Math.floor(Math.random()*sumFitness);
		// in che zona ricade?
		int[] buckets = new int[sumFitness];
		// n buckets quanto la fitness totale (verrà un qualcosa del tipo 11123333445556... ecc ecc)
		int i=0; // i-esimo bucket
		for (int p = 0; p < popolazione.length; p++)
		{
			for(int j=0;j<getFitness(popolazione[p]);j++) // j mi serve per indicare quanti bucket si deve prenotare un individuo
			{
				buckets[i] = p;
				i++;
			}
		}
		//System.out.println("Buckets attuali: "+arraytoString(buckets));
		
		return popolazione[buckets[randomNumber]];

	}
	// Calcola la fitness, in questo caso il numero di 1 presenti nell'individuo
	private static int getFitness(int[] individuo)
	{
		int sum = 0;
		for (int i=0;i<individuo.length;i++)
		{
			sum += individuo[i];
		}
		return sum;
	}

	// Crea la popolazione allo step 0
	private static int[][] createPopulation(int nIndividui, int sizeIndividui)
	{
		int[][] popolazione = new int[nIndividui][sizeIndividui];
		System.out.println("Generazione 0 --------");
		for (int i=0; i<nIndividui;i++)
		{
			for (int j=0; j<sizeIndividui;j++)
			{
				popolazione[i][j] = (int) Math.floor(Math.random()*2);
			}
			System.out.println("Individuo "+(i+1)+": "+arraytoString(popolazione[i])+" con fitness "+getFitness(popolazione[i]));
		}
		
		return popolazione;
	}
	
	// semplice metodo per visualizzare come stringa un array di bit
	private static String arraytoString(int[] array)

	{
		String res="";
		for (int i=0;i<array.length;i++)
		{
			res+=array[i];
		}
		return res;
	}
}
