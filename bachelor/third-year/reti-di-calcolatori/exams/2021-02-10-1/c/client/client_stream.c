/*
 * Cognome: Lombardi
 * Nome: Matteo
 * Matricola: 0001071217
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

#define LENGTH_ID 6
#define LENGTH_MODELLO 20
#define LENGTH_NOME_FILE 256
#define DIM_BUFF 100

int main(int argc, char *argv[]) {
    int sd, nread, port;
    struct hostent *host;
    struct sockaddr_in servaddr;

    /* CONTROLLO ARGOMENTI ---------------------------------- */
    if (argc != 3) {
        printf("Error:%s serverAddress serverPort\n", argv[0]);
        exit(1);
    }
    printf("Client avviato\n");

    /* PREPARAZIONE INDIRIZZO SERVER ----------------------------- */
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

    /* CREAZIONE E CONNESSIONE SOCKET (BIND IMPLICITA) ----------------- */
    sd = socket(AF_INET, SOCK_STREAM, 0);
    if (sd < 0) {
        perror("apertura socket ");
        exit(3);
    }
    printf("Creata la socket sd=%d\n", sd);

    if (connect(sd, (struct sockaddr *)&servaddr, sizeof(struct sockaddr)) < 0) {
        perror("Errore in connect");
        exit(4);
    }
    printf("Connect ok\n");

    /* CORPO DEL CLIENT: */
    char c, ok[2], modello[LENGTH_MODELLO], id[LENGTH_ID], nome_file_foto[LENGTH_NOME_FILE], buff[DIM_BUFF];
    int num_sci, i, fd_foto;
    long dim_file_foto, totread;

    /* ciclo di accettazione di richieste di file ------- */
    printf("Modello: ");

    while (gets(modello)) {
        // -> modello
        if (write(sd, modello, LENGTH_MODELLO) < 0) {
            perror("write");
            break;
        }
        printf("Richiesta di download degli sci con modello %s inviata\n", modello);

        // <- numero sci
        if (read(sd, &num_sci, sizeof(num_sci)) < 0) {
            perror("read");
            break;
        }
        printf("Download di %d sci\n", num_sci);

        // for numero sci
        for (i = 0; i < num_sci; i++) {
            // <- id
            if (read(sd, &id, LENGTH_ID) < 0) {
                perror("read");
                break;
            }
            printf("Download sci con identificatore %s\n", id);

            // <- N/S
            if (read(sd, &ok, (strlen(ok) + 1)) < 0) {
                perror("read");
                break;
            }
            printf("Ok: %s\n", ok);

            if (strcmp(ok, "S") == 0) {
                // <- nome file foto
                if (read(sd, &nome_file_foto, LENGTH_NOME_FILE) < 0) {
                    perror("read");
                    break;
                }

                fd_foto = open(nome_file_foto, O_WRONLY|O_CREAT, 0644);

                // dimensione file foto
                if (read(sd, &dim_file_foto, sizeof(long)) < 0) {
                    perror("read");
                    break;
                }
                printf("Download foto %s di dimensione %d\n", nome_file_foto, dim_file_foto);

                // <- file foto
                totread = 0;
                while (totread < dim_file_foto && (nread = read(sd, &buff, DIM_BUFF)) > 0) {
                    write(fd_foto, &buff, nread);
                    totread += nread;
                }
                if (nread < 0) {
                    perror("read");
                    break;
                }
                close(fd_foto);

                printf("Download foto %s completato\n", nome_file_foto);
            } else if (strcmp(ok, "N") == 0) printf("Foto %s saltata\n", nome_file_foto);
        }
        
        printf("Modello: ");
    }

    printf("\nClient: termino...\n");
    shutdown(sd, 0);
    shutdown(sd, 1);
    close(sd);
    exit(0);
}