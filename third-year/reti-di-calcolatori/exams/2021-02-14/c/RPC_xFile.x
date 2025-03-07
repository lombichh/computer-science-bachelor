/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

const MAX_NUM_PREN = 30;
const ID_SERIALE_LENGTH = 7;
const CARTA_ID_LENGTH = 5;
const BRAND_LENGTH = 5;
const MAX_FOLDER_LENGTH = 20;

struct Prenotazione {
	char id_seriale[ID_SERIALE_LENGTH];
    char carta_id[CARTA_ID_LENGTH];
    char brand[BRAND_LENGTH];
    char img_folder[MAX_FOLDER_LENGTH];
};

struct Prenotazioni {
    Prenotazione prenotazioni[MAX_NUM_PREN];
};

struct Brand {
    char brand[BRAND_LENGTH];
};

struct Id_seriale {
    char id_seriale[ID_SERIALE_LENGTH];
};


program PREN {
	version PRENVERS{
		Prenotazioni VISUALIZZA_PRENOTAZIONI(Brand) = 1;
		int ELIMINA_MONOPATTINO(Id_seriale) = 2;
	} = 1;
} = 0x20000013;