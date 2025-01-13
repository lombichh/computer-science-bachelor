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

#define MAX_NUM_STUDENTI 50

// variabili globali private (static)
static Studente lista_studenti[MAX_NUM_STUDENTI];
static int inizializzato = 0;

/* Inizializza lo stato del server */
void inizializza() {
    int i;
    if (inizializzato == 1) {
        return;
    }

    // Tutti inizialmente liberi
    for (i = 0; i < MAX_NUM_STUDENTI; i++) {
        strcpy(lista_studenti[i].matricola, "L");
        strcpy(lista_studenti[i].nome, "L");
        strcpy(lista_studenti[i].cognome, "L");
        lista_studenti[i].voto = -1;
    }

    // Inizializziamo qualche valore per i test

    inizializzato = 1;
    printf("Terminata inizializzazione struttura dati!\n");
}

// implementazione delle procedure definite nel file XDR
int *elimina_prenotazione_1_svc(Matricola *matricola, struct svc_req *reqstp) {
    static int res;
    int i, found = 0;

    if (inizializzato == 0) {
        inizializza();
    }

    // elimina prenotazione
    for (i = 0; i < MAX_NUM_STUDENTI; i++) {
        if (!found) {
            if (strcmp(lista_studenti[i].matricola, matricola) == 0) {
                found = 1;
            }
        } else {
            strcpy(lista_studenti[i-1].matricola, lista_studenti[i].matricola);
            strcpy(lista_studenti[i-1].nome, lista_studenti[i].nome);
            strcpy(lista_studenti[i-1].cognome, lista_studenti[i].cognome);
            lista_studenti[i-1].voto = lista_studenti[i].voto;
        }
    }
    strcpy(lista_studenti[MAX_NUM_STUDENTI-1].matricola, "L");
    strcpy(lista_studenti[MAX_NUM_STUDENTI-1].nome, "L");
    strcpy(lista_studenti[MAX_NUM_STUDENTI-1].cognome, "L");
    lista_studenti[MAX_NUM_STUDENTI-1].voto = -1;

    return &res;
}

Output *visualizza_voto_maggiore_soglia_1_svc(int *voto_min, struct svc_req *reqstp) {
    static Output output;
    int i, index = 0;

    // crea lista output
    for (i = 0; i < MAX_NUM_STUDENTI; i++) {
        if (lista_studenti[i] > voto_min) {
            strcpy(output->lista_studenti[index].matricola, lista_studenti[i].matricola);
            strcpy(output->lista_studenti[index].nome, lista_studenti[i].nome);
            strcpy(output->lista_studenti[index].cognome, lista_studenti[i].cognome);
            output->lista_studenti[index].voto = lista_studenti[i].voto;

            index++;
            if (index >= MAX_LISTA_SIZE) break;
        }
    }
    for (i = index; i < MAX_LISTA_SIZE; i++) {
        strcpy(output->lista_studenti[index].matricola, "L");
    }

    return (&output);
}