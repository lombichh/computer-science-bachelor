/* 
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Compito: 1
 */

const MAX_LISTA_SIZE = 5;
const MAX_MATRICOLA_SIZE = 20;
const MAX_NAME_SIZE = 128;

struct Matricola {
    char matricola[MAX_MATRICOLA_SIZE];
};

struct Studente {
    char matricola[MAX_MATRICOLA_SIZE];
    char nome[MAX_NAME_SIZE];
    char cognome[MAX_NAME_SIZE];
    int voto;
};

struct Output{
	Studente lista_studenti[MAX_LISTA_SIZE];
};
  
program RPC {
	version RPCVERS {
		int ELIMINA_PRENOTAZIONE(Matricola) = 1;
        Output VISUALIZZA_VOTO_MAGGIORE_SOGLIA(int) = 2;
	} = 1;
} = 0x20000013;

