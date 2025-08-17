/*
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Compito: 1
 */

#include <fcntl.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define DIM_BUFF         100
#define LENGTH_FILE_NAME 20

int main(int argc, char *argv[]) {
    // rete
    int sd, nread, port;
    struct hostent    *host;
    struct sockaddr_in servaddr;

    // richiesta
    char c, prefisso[LENGTH_FILE_NAME], nome_file[LENGTH_FILE_NAME];
    int file_fd, valid;

    /* controllo argomenti */
    if (argc != 3) {
        printf("Error:%s serverAddress serverPort\n", argv[0]);
        exit(1);
    }
    printf("Client avviato\n");

    /* preparazione indirizzo server */
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

    servaddr.sin_addr.s_addr = ((struct in_addr *)(host->h_addr))->s_addr;
    servaddr.sin_port = htons(port);

    /* creazione e connessione socket (bind implicita) */
    sd = socket(AF_INET, SOCK_STREAM, 0);
    if (sd < 0) {
        perror("apertura socket ");
        exit(3);
    }
    printf("Creata la socket sd=%d\n", sd);

    if (connect(sd, (struct sockaddr *) &servaddr, sizeof(struct sockaddr)) < 0) {
        perror("Errore in connect");
        exit(4);
    }
    printf("Connect ok\n");

    /* ciclo di accettazione di richieste di file */
    printf("Prefisso del file: ");
    while (gets(prefisso)) {
        if (write(sd, prefisso, (strlen(prefisso) + 1)) < 0) {
            perror("write");
            break;
        }
        printf("Richiesta dei file con prefisso %s inviata... \n", prefisso);

        // ciclo di ricezione dei file
        while ((nread = read(sd, nome_file, strlen(nome_file))) > 0) {
            // controlla se file esiste già
            printf("File name: %s\n", nome_file);
            if ((file_fd = open(nome_file, O_WRONLY|O_CREAT, 0666)) == -1) {
                perror("open file");
                valid = 0;
                if (write(sd, &valid, sizeof(valid)) < 0) {
                    perror("write");
                    break;
                }
                break;
            }
            valid = 1;
            if (write(sd, &valid, sizeof(valid)) < 0) {
                perror("write");
                break;
            }
            // ricezione file
            printf("Ricevo il file:\n");
            while ((nread = read(sd, &c, 1)) > 0) { // leggo a caratteri per individuare il fine file
                if (c != '\0') {
                    write(file_fd, &c, 1);
                } else break;
            }
            if (nread < 0) {
                perror("read");
                break;
            }
        }
        if (nread < 0) {
            perror("read");
            break;
        }
        printf("Prefisso del file: ");
    }

    printf("\nClient: termino...\n");
    shutdown(sd, 0);
    shutdown(sd, 1);
    close(sd);
    exit(0);
}