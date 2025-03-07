/*
 * Cognome: Lombardi
 * Nome: Matteo
 * Matricola: 0001071217
 */

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <netinet/in.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/stat.h>

// TODO:
// refactor

#define LENGTH_ID 6
#define LENGTH_DATA 11
#define LENGTH_MODELLO 20
#define LENGTH_NOME_FILE 256
#define MAX_NUM_NOLEGGI 30
#define DIM_BUFF 100

#define max(a, b) ((a) > (b) ? (a) : (b))

typedef struct {
    char id[LENGTH_ID];
    char data[LENGTH_DATA];
    int giorni;
    char modello[LENGTH_MODELLO];
    int costo_giornaliero;
    char nome_file_foto[LENGTH_NOME_FILE];
} Noleggio;
static Noleggio noleggi[MAX_NUM_NOLEGGI];

void gestore(int signo) {
    int stato;
    printf("esecuzione gestore di SIGCHLD\n");
    wait(&stato);
}

int main(int argc, char **argv) {
    int listenfd, connfd, udpfd, nready, maxfdp1;
    const int on = 1;
    fd_set rset;
    int len, nread, num, port;
    struct sockaddr_in cliaddr, servaddr;

    /* CONTROLLO ARGOMENTI ---------------------------------- */
    if (argc != 2) {
        printf("Error: %s port\n", argv[0]);
        exit(1);
    }
    nread = 0;
    while (argv[1][nread] != '\0') {
        if ((argv[1][nread] < '0') || (argv[1][nread] > '9')) {
            printf("Terzo argomento non intero\n");
            exit(2);
        }
        nread++;
    }
    port = atoi(argv[1]);
    if (port < 1024 || port > 65535) {
        printf("Porta scorretta...");
        exit(2);
    }

    /* INIZIALIZZAZIONE INDIRIZZO SERVER ----------------------------------------- */
    memset((char *)&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port = htons(port);

    printf("Server avviato\n");

    /* CREAZIONE SOCKET TCP ------------------------------------------------------ */
    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    if (listenfd < 0) {
        perror("apertura socket TCP ");
        exit(1);
    }
    printf("Creata la socket TCP d'ascolto, fd=%d\n", listenfd);

    if (setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on)) < 0) {
        perror("set opzioni socket TCP");
        exit(2);
    }
    printf("Set opzioni socket TCP ok\n");

    if (bind(listenfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
        perror("bind socket TCP");
        exit(3);
    }
    printf("Bind socket TCP ok\n");

    if (listen(listenfd, 5) < 0) {
        perror("listen");
        exit(4);
    }
    printf("Listen ok\n");

    /* CREAZIONE SOCKET UDP ------------------------------------------------ */
    udpfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (udpfd < 0) {
        perror("apertura socket UDP");
        exit(5);
    }
    printf("Creata la socket UDP, fd=%d\n", udpfd);

    if (setsockopt(udpfd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on)) < 0) {
        perror("set opzioni socket UDP");
        exit(6);
    }
    printf("Set opzioni socket UDP ok\n");

    if (bind(udpfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
        perror("bind socket UDP");
        exit(7);
    }
    printf("Bind socket UDP ok\n");

    /* AGGANCIO GESTORE PER EVITARE FIGLI ZOMBIE -------------------------------- */
    signal(SIGCHLD, gestore);

    /* PULIZIA E SETTAGGIO MASCHERA DEI FILE DESCRIPTOR ------------------------- */
    FD_ZERO(&rset);
    maxfdp1 = max(listenfd, udpfd) + 1;

    /* INIZIALIZZAZIONE STRUTTURA NOLEGGI */
    int i;
    for (i = 0; i < MAX_NUM_NOLEGGI; i++) {
        strcpy(noleggi[i].id, "L");
        strcpy(noleggi[i].data, "L");
        noleggi[i].giorni = -1;
        strcpy(noleggi[i].modello, "L");
        noleggi[i].costo_giornaliero = -1;
        strcpy(noleggi[i].nome_file_foto, "L");
    }

    // valori per test
    strcpy(noleggi[1].id, "12F4S");
    strcpy(noleggi[1].modello, "mybrand");
    strcpy(noleggi[1].nome_file_foto, "sci1.avif");

    strcpy(noleggi[3].id, "12F4E");
    strcpy(noleggi[3].modello, "mybrand");
    strcpy(noleggi[3].nome_file_foto, "sci2.jpg");

    /* CICLO DI RICEZIONE EVENTI DALLA SELECT ----------------------------------- */
    char ok, zero = 0, modello[LENGTH_MODELLO], buff[DIM_BUFF];
    int num_sci, fd_file_foto;
    struct stat st;
    long totread;

    char id[LENGTH_ID];
    
    for (;;) {
        FD_SET(listenfd, &rset);
        FD_SET(udpfd, &rset);

        if ((nready = select(maxfdp1, &rset, NULL, NULL, NULL)) < 0) {
            if (errno == EINTR)
                continue;
            else {
                perror("select");
                exit(8);
            }
        }

        if (FD_ISSET(listenfd, &rset)) { // client stream: download sci
            printf("Stream: ricezione richiesta di download sci\n");

            len = sizeof(struct sockaddr_in);
            if ((connfd = accept(listenfd, (struct sockaddr *)&cliaddr, &len)) < 0) {
                if (errno == EINTR)
                    continue;
                else {
                    perror("accept");
                    exit(9);
                }
            }

            if (fork() == 0) { /* processo figlio che serve la richiesta di operazione */
                close(listenfd);
                printf("Stream: dentro il figlio, pid=%i\n", getpid());

                while((nread = read(connfd, &modello, LENGTH_MODELLO)) > 0) {
                    printf("Stream: ricezione richiesta di download sci con modello %s\n", modello);

                    // <- numero sci
                    num_sci = 0;
                    for (i = 0; i < MAX_NUM_NOLEGGI; i++) {
                        if (strcmp(noleggi[i].modello, modello) == 0) num_sci++;
                    }
                    if (write(connfd, &num_sci, sizeof(num_sci)) < 0) {
                        perror("write");
                        break;
                    }
                    printf("Stream: download di %d sci\n", num_sci);

                    // for numero sci
                    for (i = 0; i < MAX_NUM_NOLEGGI; i++) {
                        if (strcmp(noleggi[i].modello, modello) == 0) {
                            // -> id
                            if (write(connfd, &noleggi[i].id, LENGTH_ID) < 0) {
                                perror("write");
                                break;
                            }
                            printf("Stream: download sci con identificatore %s\n", noleggi[i].id);

                            // -> N/S
                            fd_file_foto = open(noleggi[i].nome_file_foto, O_RDONLY);

                            if (fd_file_foto >= 0) {
                                if (write(connfd, "S", 1) < 0) {
                                    perror("write");
                                    break;
                                }

                                printf("Stream: invio la foto %s\n", noleggi[i].nome_file_foto);

                                // -> nome file foto
                                if (write(connfd, &noleggi[i].nome_file_foto, LENGTH_NOME_FILE) < 0) {
                                    perror("write");
                                    break;
                                }

                                // -> dimensione file foto
                                if (stat(noleggi[i].nome_file_foto, &st) != 0) {
                                    perror("stat");
                                    break;
                                }
                                if (write(connfd, &st.st_size, sizeof(long)) < 0) {
                                    perror("write");
                                    break;
                                }

                                // -> file foto
                                totread = 0;
                                while(totread < st.st_size && (nread = read(fd_file_foto, &buff, DIM_BUFF)) > 0) {
                                    if (write(connfd, &buff, nread) < 0) {
                                        perror("write"); 
                                        break;
                                    }
                                    totread += nread;
                                }
                                close(fd_file_foto);
                                if (nread < 0) {
                                    perror("read");
                                    break;
                                }
                                printf("Stream: invio foto %s completato\n", noleggi[i].nome_file_foto);
                            } else {
                                if (write(connfd, "N", 1) < 0) {
                                    perror("write");
                                    break;
                                }
                                printf("Foto %s saltata", noleggi[i].nome_file_foto);
                            }
                        }
                    }
                }

                close(connfd); 
                exit(0); // Chiusura della connessione all’uscita dal ciclo
            }
            close(connfd); // Padre: chiusura socket di comunicazione e suo ciclo
        }

        if (FD_ISSET(udpfd, &rset)) { // client datagram: valutazione costo noleggio
            printf("Datagram: ricevuta richiesta di valutazione costo noleggio\n");

            len = sizeof(struct sockaddr_in);
            if (recvfrom(udpfd, &id, sizeof(id), 0, (struct sockaddr *) &cliaddr, &len) < 0) {
                perror("recvfrom");
                continue;
            }

            printf("Datagram: richiesta valutazione costo noleggio con id %s\n", id);
            
            // TODO


        }
    }
}