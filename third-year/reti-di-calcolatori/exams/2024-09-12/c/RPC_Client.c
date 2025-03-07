/* 
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Compito: 1
 */

#include "RPC.h"
#include <rpc/rpc.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// cosa significa ^D
// perchè consumare il fine linea con scanf %s

// TODO
// riformatta, cambia commenti e nomi variabili
// inizializzare struttura con valori di test

int main(int argc, char *argv[]) {
    char   *host; // nome host
    CLIENT *cl;   // gestore del trasporto

    char choice[2], endl[2];

    // elimina prenotazione
    static Matricola matricola;
    int *ris;

    // lista voto > soglia
    static int voto_min;
    Output *output;

    // Controllo degli argomenti
    if (argc != 2) {
        printf("usage: %s server_host\n", argv[0]);
        exit(1);
    }
    host = argv[1];

    // Creazione gestore del trasporto
    cl = clnt_create(host, OPERATION, OPERATIONVERS, "udp");
    if (cl == NULL) {
        clnt_pcreateerror(host);
        exit(1);
    }

    // Interazione con l'utente
    printf("Inserire:\n1\tElimina prenotazione\n2\tLista studenti con voti maggiori\n^D\tper terminare: ");

    while (scanf("%s", choice) == 1) {
        // Consuma fine linea
        gets(&endl);

        /* 1 - Elimina prenotazione */
        if (strcmp(choice, "1") == 0) {
            printf("\nInserisci la matricola: ");
            gets(matricola.matricola);

            // Invocazione remota
            ris = elimina_prenotazione_1(matricola, cl);
            // Controllo del risultato
            if (ris == NULL) {
                // Errore di RPC
                clnt_perror(cl, host);
                exit(1);
            }

            if (*ris == 1) printf("Cancellazione andata a buon fine\n");
            else printf("Errore nella cancellazione\n");
        }
        /* 2 - Lista studenti con voti maggiori */
        else if (strcmp(choice, "2") == 0) {
            printf("\nInserisci il voto minimo: ");
            gets(&voto_min);

            // Invocazione remota
            output = visualizza_voto_maggiore_soglia_1(&voto_min, cl);

            // Controllo del risultato
            if (output == NULL) {
                // Errore di RPC
                clnt_perror(cl, host);
                exit(1);
            }

            for (int i = 0; i < MAX_LISTA_SIZE; i++) {
                if (strcmp(output->lista_studenti[i].matricola, "L") != 0) {
                    printf("Matricola: %s; Nome: %s; Cognome: %s; Voto: %d\n", output->lista_studenti[i].matricola,
                           output->lista_studenti[i].nome, output->lista_studenti[i].cognome,
                           output->lista_studenti[i].voto
                }
            }
        } else {
            printf("Operazione richiesta non disponibile!!\n");
        }

        printf("Inserire:\n1\tElimina prenotazione\n2\tLista studenti con voti maggiori\n^D\tper terminare: ");
    } // while

    // Libero le risorse, distruggendo il gestore di trasporto
    clnt_destroy(cl);
    exit(0);
} // main