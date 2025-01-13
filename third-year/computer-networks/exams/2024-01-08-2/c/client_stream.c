/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
 */

/* Client per richiedere l'invio di un file (get, versione 1) */

#include <fcntl.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define DIM_BUFF 100
#define LENGTH_FILE_NAME 20

int main(int argc, char *argv[]) {
    int sd, nread, port;
    struct hostent *host;
    struct sockaddr_in servaddr;

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

    servaddr.sin_addr.s_addr = ((struct in_addr *) (host->h_addr))->s_addr;
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

    /* corpo del client */
    char nome_dir[LENGTH_FILE_NAME], nome_file[LENGTH_FILE_NAME], buff[DIM_BUFF];
    int num_file, fd, i, dim_file, tot_read;

    printf("Nome del direttorio: ");
    while (gets(nome_dir)) {
        // -> nome dir
        // <- numero file
        // <- nome file
        // <- dimensione file
        // <- contenuto file

        // invio nome dir
        if (write(sd, nome_dir, (strlen(nome_dir) + 1)) < 0) {
            perror("write");
            break;
        }
        printf("Richiesta del direttorio %s inviata... \n", nome_dir);

        // ricezione numero file
        if (read(sd, &num_file, sizeof(num_file))) {
            perror("read");
            break;
        }
        printf("Ricezione di %d file\n", num_file);

        // ricezione file
        for (i = 0; i < num_file; i++) {
            // ricezione nome file e dimensione
            if (read(sd, &nome_file, sizeof(nome_file)) > 0
                && read(sd, &dim_file, sizeof(dim_file)) > 0) {
                perror("read");
                exit(1);
            }

            // creazione file
            if (fd = open(nome_file, O_WRONLY|O_CREAT, 0644) > 0) {
                perror("open");
                exit(1);
            }

            // ricezione e scrittura file
            tot_read = 0;
            while (tot_read < dim_file) {
                if ((nread = read(sd, buff, DIM_BUFF)) <= 0) {
                    perror("read file");
                    exit(1);
                }
                write(fd, buff, nread);
                tot_read += nread;
            }
            printf("Trasferimento file %s terminato\n", nome_file);
        }
    }

    printf("\nClient: termino...\n");
    shutdown(sd, 0);
    shutdown(sd, 1);
    close(sd);
    exit(0);
}