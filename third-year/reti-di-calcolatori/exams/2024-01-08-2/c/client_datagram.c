/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

#include <dirent.h>
#include <fcntl.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define LINE_LENGTH 256
#define LENGTH_FILE_NAME 20

typedef struct {
    char nome_dir[LENGTH_FILE_NAME];
    char car;
    int occ;
} Request;

int main(int argc, char **argv) {
    struct hostent *host;
    struct sockaddr_in clientaddr, servaddr;
    int sd, nread, port, len;

    Request req;
    char okstr[LINE_LENGTH];
    int ris;

    /* controllo argomenti */
    if (argc != 3) {
        printf("Error:%s serverAddress serverPort\n", argv[0]);
        exit(1);
    }

    /* inizializzazione indirizzo server */
    memset((char *) &servaddr, 0, sizeof(struct sockaddr_in));
    servaddr.sin_family = AF_INET;
    host = gethostbyname(argv[1]);
    if (host == NULL) {
        printf("%s not found in /etc/hosts\n", argv[1]);
        exit(2);
    }

    nread = 0;
    while (argv[2][nread] != '\0') {
        if ((argv[2][nread] < '0') || (argv[2][nread] > '9')) {
            printf("Secondo argomento non intero\n");
            exit(2);
        }
        nread++;
    }
    port = atoi(argv[2]);
    if (port < 1024 || port > 65535) {
        printf("Porta scorretta...");
        exit(2);
    }

    servaddr.sin_addr.s_addr = ((struct in_addr *) (host->h_addr))->s_addr;
    servaddr.sin_port = htons(port);

    /* inizializzazione indirizzo client */
    memset((char *) &clientaddr, 0, sizeof(struct sockaddr_in));
    clientaddr.sin_family = AF_INET;
    clientaddr.sin_addr.s_addr = INADDR_ANY;
    clientaddr.sin_port = 0;

    printf("Client avviato\n");

    /* creazione socket */
    sd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sd < 0) {
        perror("apertura socket");
        exit(3);
    }
    printf("Creata la socket sd=%d\n", sd);

    /* bind socket */
    if (bind(sd, (struct sockaddr *) &clientaddr, sizeof(clientaddr)) < 0) {
        perror("bind socket ");
        exit(1);
    }
    printf("Client: bind socket ok, alla porta %i\n", clientaddr.sin_port);

    /* corpo del client */
    printf("Nome del direttorio remoto: ");

    while (gets(req.nome_dir)) {
        // invio parametri
        // nome_dir, car, occ (tramite struttura)
        printf("Carattere: ");
        req.car = getchar();
        gets(okstr); // consumo resto linea

        printf("Numero occorrenze (intero): ");
        while (scanf("%i", &req.occ) != 1) {
            gets(okstr); // consumo resto linea
            printf("Numero occorrenze (intero): ");
        }

        len = sizeof(servaddr);
        if (sendto(sd, &req, sizeof(Request), 0, (struct sockaddr_in *) &servaddr, len) < 0) {
            perror("sendto");
            continue;
        }

        // ricezione risultato
        printf("Attesa del risultato...\n");
        if (recvfrom(sd, &ris, sizeof(ris), 0, (struct sockaddr_in *) &servaddr, &len) < 0) {
            perror("recvfrom");
            continue;
        }

        if (ris >= 0) printf("Numero di linee che contengono almeno %d occorrenze del carattere %c nel direttorio remoto %s: %d",
            req.occ, req.car, req.nome_dir, ris);
        else printf("Problemi nell'esecuzione dell'istruzione");

        printf("Nome del direttorio remoto: ");
    }

    printf("\nClient: termino...\n");
    shutdown(sd, 0);
    shutdown(sd, 1);
    close(sd);
    exit(0);
}
