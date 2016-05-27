#ifndef UTILS_H
#define UTILS_H

#include "strutture.h"


//! Legge un numero da console
/*! @param message testo opzionale da mostrare
 *	@param ntype il tipo di numero da acquisire
 */
auto getNumberFromConsole(string message="", char nType='u') -> unsigned int
{
	string input = "";
	cout << message;
	getline(cin, input);

	if(nType=='u') // unsigned int
	{
		unsigned int numero = 0;
		stringstream myStream(input);
		myStream >> numero;
		return numero;
	}
	else if(nType=='d') // double
	{
		double numero = 0;
		stringstream myStream(input);
		myStream >> numero;
		return numero;
	}
	// Se l'utente non inserisce nulla
    unsigned int fallback = 0;
    return fallback;
}

//! Mostra a schermo il logo del programma
void printLogo()
{
	printf("	***********************************		\n");
	printf("	 	    CVRP/TSP with ACO              	\n");
	printf("	  di Illuminato Luca Costantino   		\n");
	printf("	***********************************		\n");
}

//! Genera un numero a caso
/*! @param minOffset l'estremo inferiore
 *	@param maxOffset l'estremo superiore
 *	@return il numero generato con distribuzione uniforme
 */
uint16_t randomNumber(const uint16_t &minOffset, const uint16_t &maxOffset)
{
    //the random device that will seed the generator
    random_device seeder;
    //then make a mersenne twister engine
    mt19937 engine(seeder());
    //then the easy part... the distribution
    uniform_int_distribution<uint16_t> dist(minOffset, maxOffset);
    //then just generate the integer like this:
    return dist(engine);
}

//! Conversione stringa a intero
uint16_t stringToInt(const string &input)
{
    uint16_t i_output;
    stringstream myidStream(input); // id
    myidStream >> i_output;
    return i_output;
}

//! Legge un file e lo memorizza in un vettore di stringhe
/*!	@param filename il nome del file da leggere
 *	@return il contenuto del file come vettore di stringhe
 */
vectorString readFile(const string &filename)
{
    string line;
    vectorString content;
    ifstream iusrfile;
    iusrfile.open(filename);
    if(!iusrfile.is_open())
        cout << "Errore apertura del file!\n";
    for(unsigned int i=0; getline( iusrfile, line ); i++)
        content.push_back(line);
    iusrfile.close();
    return content;
}

void debugPrint(const char* message)
{
    if(ACOVARS.verbose)	printf(message);
}

//! Copia un vettore in un altro, correggendo l'eventuale differenza di dimensioni
void copiaVettore(vectorUint &origine, vectorUint &destinazione)
{
	uint16_t sizeOrig = origine.size();
	uint16_t sizeDest = destinazione.size();
	if(sizeOrig!=sizeDest)
		destinazione.resize(sizeOrig);
	copy(origine.begin(),origine.end(), destinazione.begin() );
}

//! Fai la media dei costi
double mediaCosti(vectorUint &costi)
{
	auto sommaCosti = accumulate(costi.begin(),costi.end(),0);
	double media = (double) sommaCosti / ACOVARS.nAnt;
	return media;
}

//! Fa lo split di una stringa
/*!	@param line la stringa da dividere
 *	@param delimiter il delimitatore
 *	@return l'insieme dei token
 */
string* string_split(string line, string delimiter)
{
    size_t pos = 0;
    string* token = new string[4];
    int i = 0;
    while ((pos = line.find(delimiter)) != string::npos)
    {
        string tmpline = line.substr(0, pos);
        if(tmpline.size()>0)
        {
            token[i] = tmpline;
            ++i;
        }

        line.erase(0, pos + delimiter.length());

    }
    if(line.size()>0)
        token[i] = line;
    return token;
}

//! Leggi una stringa da console
/*! @param message messaggio eventuale da far apparire in console
 *	@return la stringa letta
 */
string readStringFromConsole(const string &message="")
{
    string nomefile = "";
    if(message.size()>0) cout << message;
    getline(cin, nomefile);
    return nomefile;
}

uint16_t readIntFromConsole(const string &message="")
{
    if(message.size()>0)
        cout << message;

    uint16_t i_diretto = 0;
    string input = "";
    getline(cin, input);
    if(input=="") return 0;
    stringstream myStream(input);
    myStream >> i_diretto;
    return i_diretto;
}

void subSeqSwap(vectorUint &tour, const uint16_t &inizio, const uint16_t &fine, uint16_t length)
{
	if(fine-inizio<length) length = fine-inizio;
	for(uint16_t k=0;k<length;k++)
	{
		uint16_t tmp = tour[inizio+k];
		tour[inizio+k] = tour[fine+k];
		tour[fine+k] = tmp;
	}
}

#endif // UTILS_H
