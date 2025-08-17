/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

#include "RPC_xFile.h"
#include <fcntl.h>
#include <rpc/rpc.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>

/* STATO SERVER */
static Prenotazione prenotazioni[MAX_NUM_PREN];
static int inizializzato = 0;

void inizializza() {
    if (inizializzato == 1) return;

    int i;

    // inizializzazione struttura dati
    for (i = 0; i < MAX_NUM_PREN; i++) {
        strcpy(prenotazioni[i].id_seriale, "L");
        strcpy(prenotazioni[i].carta_id, "L");
        strcpy(prenotazioni[i].brand, "L");
        strcpy(prenotazioni[i].img_folder, "L");
    }

    // TODO: inserisci valori per test

    inizializzato = 1;
    printf("Terminata inizializzazione struttura dati!\n");
}

Prenotazioni *visualizza_prenotazioni_1_svc(Brand *brand, struct svc_req *rqstp) {
    static Prenotazioni prenotazioni_ris;

    int i, index;

    if (inizializzato == 0) {
        inizializza();
    }

    printf("Ricevuta richiesta di visualizzazione prenotazioni per brand %s\n", brand->brand);

    index = 0;
    for (i = 0; i < MAX_NUM_PREN; i++) {
        if (prenotazioni[i].id_seriale[0] == 'E'
            && prenotazioni[i].id_seriale[1] == 'D'
            && strcmp(prenotazioni[i].brand, brand->brand) == 0) {
            strcpy(prenotazioni_ris[i].id_seriale, prenotazioni[i].id_seriale);
            strcpy(prenotazioni_ris[i].carta_id, prenotazioni[i].carta_id);
            strcpy(prenotazioni_ris[i].brand, prenotazioni[i].brand);
            strcpy(prenotazioni_ris[i].img_folder, prenotazioni[i].img_folder);

            index++;
        }
    }

    return(&prenotazioni_ris);
}

int *elimina_monopattino_1_svc(Id_seriale *id_seriale, struct svc_req *rqstp) {
    static int ris = -1;

    int i;
    DIR *img_folder;
    struct dirent *img;
    char img_fullpath[256];

    if (inizializzato == 0) {
        inizializza();
    }

    printf("Ricevuta richiesta di eliminazione del monopattino con id: %s\n", id_seriale->id_seriale);

    for (i = 0; i < MAX_NUM_PREN; i++) {
        if (strcmp(prenotazioni[i].id_seriale, id_seriale->id_seriale) == 0) {
            if (strcmp(prenotazioni[i].carta_id, "L") == 0) {
                // elimina immagini da folder
                if ((img_folder = opendir(prenotazioni[i].img_folder)) != NULL) { // direttorio presente
                    while ((img = readdir(img_folder)) != NULL) {
                        if (strcmp(img->d_name, ".") != 0 && strcmp(img->d_name, "..") != 0) {
                            img_fullpath[0] = '\0';
                            strcat(img_fullpath, prenotazioni[i].img_folder);
                            strcat(img_fullpath, "/");
                            strcat(img_fullpath, img->d_name);

                            if (remove(img_fullpath) == 0) printf("Immagine %s eliminata con successo\n", img_fullpath);
                        }
                    }
                }

                // libera monopattino
                strcpy(prenotazioni_ris[i].id_seriale, "L");
                strcpy(prenotazioni_ris[i].carta_id, "L");
                strcpy(prenotazioni_ris[i].brand, "L");
                strcpy(prenotazioni_ris[i].img_folder, "L");

                ris = 0;
            } else ris = -1;

            break;
        }
    }

    return(&ris);
}