/*
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Compito: 1
 */

/* dgram_client.c
 * chiede nome file e la parola, invia al server,
 * attende l’esito dell’operazione
 */

#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define LINE_LENGTH 128

typedef struct {
    char car;
    int occ;
} udp_req_t;

int main(int argc, char **argv) {
    // rete
    struct hostent *host;
    struct sockaddr_in clientaddr, servaddr;
    int port, nread, sd, len = 0;

    // richiesta
    char car;
    int occ;
    int ris;
    udp_req_t req;
    char c;
    char okstr[LINE_LENGTH];

    /* controllo argomenti */
    if (argc != 3) {
        printf("Usage: %s serverAddress serverPort\n", argv[0]);
        exit(1);
    }
    nread = 0;
    while (argv[2][nread] != '\0') {
        if ((argv[2][nread] < '0') || (argv[2][nread] > '9')) {
            printf("Second argument must be an integer!\n");
            printf("Usage: %s serverAddress serverPort\n", argv[0]);
            exit(2);
        }
        nread++;
    }
    port = atoi(argv[2]);
    if (port < 1024 || port > 65535) {
        printf("Port must be in the range [1024, 65535]\n");
        exit(2);
    }

    /* inizializzazione indirizzo client */
    memset((char *) &clientaddr, 0, sizeof(struct sockaddr_in));
    clientaddr.sin_family      = AF_INET;
    clientaddr.sin_addr.s_addr = INADDR_ANY;
    clientaddr.sin_port        = 0;

    /* inizializzazione indirizzo server */
    memset((char *) &servaddr, 0, sizeof(struct sockaddr_in));
    servaddr.sin_family = AF_INET;
    host = gethostbyname(argv[1]);
    if (host == NULL) {
        printf("Error while resolving %s to IP address\n", argv[1]);
        exit(2);
    } else {
        servaddr.sin_addr.s_addr = ((struct in_addr *)(host->h_addr))->s_addr;
        servaddr.sin_port = htons(port);
    }

    /* creazione socket */
    sd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sd < 0) {
        perror("Open socket: ");
        exit(3);
    }
    printf("Client: created socket sd=%d\n", sd);

    /* bind socket */
    if (bind(sd, (struct sockaddr *) &clientaddr, sizeof(clientaddr)) < 0) {
        perror("bind socket ");
        exit(1);
    }
    printf("Client: socket bound to port %i\n", clientaddr.sin_port);

    /* ciclo di accettazione di richieste da utente */
    printf("Carattere da ricercare, EOF per terminare: ");
    while (car = getchar()) {
        printf("Numero occorrenze: ");
        while (scanf("%d", &occ) != 1) {
            do {
                c = getchar();
                printf("%c ", c);
            } while (c != '\n');
            printf("Numero occorrenze (intero):");
            continue;
        }
        gets(okstr);

        req.car = car;
        req.occ = occ;

        printf("Invio richiesta di conteggio del carattere '%c' con %d occorrenze\n", req.car, req.occ);

        /* invio richiesta */
        len = sizeof(servaddr);
        if (sendto(sd, &req, sizeof(req), 0, (struct sockaddr *) &servaddr, len) < 0) {
            perror("sendto");
            // se questo invio fallisce il client torna all'inzio del ciclo
            printf("Carattere da ricercare, EOF per terminare: ");
            continue;
        }

        printf("Attendo risposta...\n");

        /* ricezione del risultato */
        if (recvfrom(sd, &ris, sizeof(ris), 0, (struct sockaddr *) &servaddr, &len) < 0) {
            perror("Error in recvfrom: ");
            // se questo invio fallisce il client torna all'inzio del ciclo
            printf("Carattere da ricercare, EOF per terminare: ");
            continue;
        }

        printf("Numero di righe con occorrenze: %d\n", ris);
        
        printf("Carattere da ricercare, EOF per terminare: ");
    }
}