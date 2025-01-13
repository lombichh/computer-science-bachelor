/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

#include "RPC_xFile.h"
#include <rpc/rpc.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    char *host;
    CLIENT *cl;

    char ok[256];

    static Brand brand;
    Prenotazioni *prenotazioni;

    static Id_seriale id_seriale;
    int *ris;

    if (argc != 2) {
        printf("usage: %s server_host\n", argv[0]);
        exit(1);
    }
    host = argv[1];

    cl = clnt_create(host, SALA, SALAVERS, "udp");
    if (cl == NULL) {
        clnt_pcreateerror(host);
        exit(1);
    }

    printf("Inserire:\nV) Visualizza prenotazioni di un certo brand successive al 2011\nE) Elimina monopattino\n");
    while (gets(ok)) {
        if (strcmp(ok, "V") == 0) { // visualizza prenotazioni
            // input parametri
            printf("Brand: ");
            gets(brand.brand);

            // invocazione remota
            prenotazioni = visualizza_prenotazioni_1(&brand, cl);
            if (prenotazioni == NULL) {
                clnt_perror(cl, host);
                exit(1);
            }
            
            // stampa risultato
            for (int i = 0; i < MAX_NUM_PREN; i++) {
                if (strcmp(prenotazioni->prenotazioni[i].id_seriale, "L") == 0) break;
                printf("Id seriale: %s; Carta identita: %s; Brand: %s; Folder immagini: %s\n",
                    prenotazioni->prenotazioni[i].id_seriale,
                    prenotazioni->prenotazioni[i].carta_id,
                    prenotazioni->prenotazioni[i].brand,
                    prenotazioni->prenotazioni[i].img_folder);
            }
        } else if (strcmp(ok, "E") == 0) { // elimina monopattino
            // input parametri
            printf("Id seriale: ");
            gets(Id_seriale.id_seriale);

            // invocazione remota
            ris = elimina_monopattino_1(&Id_seriale, cl);
            if (ris == NULL) {
                clnt_perror(cl, host);
                exit(1);
            }

            // stampa risultato
            if (*ris == 0) printf("Eliminazione del monopattino avvenuta con successo\n");
            else printf("Problemi nell'eliminazione del monopattino\n");
        } else printf("Argomento di ingresso errato!!\n");

        printf("Inserire:\nV) Visualizza prenotazioni di un certo brand successive al 2011\nE) Elimina monopattino\n");
    }

    // libero le risorse, distruggendo il gestore di trasporto
    clnt_destroy(cl);
    exit(0);
}