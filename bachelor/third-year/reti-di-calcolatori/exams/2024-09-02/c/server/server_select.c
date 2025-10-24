/*
 * Nome: Matteo
 * Cognome: Lombardi
 * Matricola: 0001071217
 * Compito: 1
 */

#include <arpa/inet.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <netinet/in.h>
#include <regex.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define DIM_BUFF 100
#define max(a, b)   ((a) > (b) ? (a) : (b))

// TODO: eliminare tutto ciò che non viene utilizzato
// TODO: modificare nome variabili
// è possibile inviare strutture tramite tcp o solo udp?

void gestore(int signo) {
    int stato;
    printf("esecuzione gestore di SIGCHLD\n");
    wait(&stato);
}

typedef struct {
    char car;
    int occ;
} udp_req_t;

int main(int argc, char **argv) {
    // rete
    struct sockaddr_in cliaddr, servaddr;
    struct hostent *hostTcp, *hostUdp;
    int port, listen_sd, conn_sd, udp_sd, nread, maxfdp1, addrlen;
    const int reuseaddr_on = 1;
    fd_set rset;
    udp_req_t req;

    // richieste datagram
    int ris_udp;
    DIR *dir_udp;
    struct dirent *d_udp;
    int fd_udp;
    int curr_occ;
    char read_char;
    char err[128];

    // richieste stream
    char prefisso[4];
    DIR *dir_tcp;
    struct dirent *d_tcp;
    int fd_tcp;
    char buff[DIM_BUFF];
    char zero = 0;
    int valid;

    /* controllo argomenti */
    if (argc != 2) {
        printf("Error: %s port \n", argv[0]);
        exit(1);
    } else {
        // controllo secondo argomento (porta)
        nread = 0;
        while (argv[1][nread] != '\0') {
            if ((argv[1][nread] < '0') || (argv[1][nread] > '9')) {
                printf("Secondo argomento non intero\n");
                exit(2);
            }
            nread++;
        }
        port = atoi(argv[1]);
        if (port < 1024 || port > 65535) {
            printf("Porta scorretta...");
            exit(2);
        }
    }

    /* inizializzazione indirizzo server */
    memset((char *) &servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port = htons(port);

    /* creazione e settaggi socket tcp */
    listen_sd = socket(AF_INET, SOCK_STREAM, 0);
    if (listen_sd < 0) {
        perror("creazione socket ");
        exit(3);
    }
    printf("Server: creata la socket d'ascolto per le richieste di ordinamento, fd=%d\n",
           listen_sd);

    if (setsockopt(listen_sd, SOL_SOCKET, SO_REUSEADDR, &reuseaddr_on, sizeof(reuseaddr_on)) < 0) {
        perror("set opzioni socket d'ascolto");
        exit(3);
    }
    printf("Server: set opzioni socket d'ascolto ok\n");

    if (bind(listen_sd, (struct sockaddr *) &servaddr, sizeof(servaddr)) < 0) {
        perror("bind socket d'ascolto");
        exit(3);
    }
    printf("Server: bind socket d'ascolto ok\n");

    if (listen(listen_sd, 5) < 0) {
        perror("listen");
        exit(3);
    }
    printf("Server: listen ok\n");

    /* creazione e settaggi socket udp */
    udp_sd = socket(AF_INET, SOCK_DGRAM, 0);
    if (udp_sd < 0) {
        perror("apertura socket UDP");
        exit(4);
    }
    printf("Creata la socket UDP, fd=%d\n", udp_sd);

    if (setsockopt(udp_sd, SOL_SOCKET, SO_REUSEADDR, &reuseaddr_on, sizeof(reuseaddr_on)) < 0) {
        perror("set opzioni socket UDP");
        exit(4);
    }
    printf("Set opzioni socket UDP ok\n");

    if (bind(udp_sd, (struct sockaddr *) &servaddr, sizeof(servaddr)) < 0) {
        perror("bind socket UDP");
        exit(4);
    }
    printf("Bind socket UDP ok\n");

    // evita figli zombie
    signal(SIGCHLD, gestore);

    // pulizia mascheria di read
    FD_ZERO(&rset);
    maxfdp1 = max(listen_sd, udp_sd) + 1;

    /* ciclo di ricezione richieste */
    for (;;) {
        FD_SET(listen_sd, &rset);
        FD_SET(udp_sd, &rset);

        if ((nread = select(maxfdp1, &rset, NULL, NULL, NULL)) < 0) {
            if (errno == EINTR) {
                continue;
            } else {
                perror("select");
                exit(5);
            }
        }

        /* gestione richieste udp */
        if (FD_ISSET(udp_sd, &rset)) {
            printf("Ricevuta richiesta di UDP: conteggio di linee specifiche\n");
            addrlen = sizeof(struct sockaddr_in);

            if (recvfrom(udp_sd, &req, sizeof(req), 0, (struct sockaddr *) &cliaddr, &addrlen) < 0) {
                perror("recvfrom ");
                continue;
            }

            // stampo le informazioni sul client
            hostUdp = gethostbyaddr((char *) &cliaddr.sin_addr, sizeof(cliaddr.sin_addr), AF_INET);
            if (hostUdp == NULL) {
                printf("Operazione richiesta da: %s\n", inet_ntoa(cliaddr.sin_addr));
            } else {
                printf("Operazione richiesta da: %s %i\n", hostUdp->h_name,
                       (unsigned)ntohs(cliaddr.sin_port));
            }

            printf("Operazione richiesta con il carattere '%c' e il numero di occorrenze: %d\n", req.car, req.occ);

            // leggo i file del direttorio
            ris_udp = 0;
            curr_occ = 0;

            if ((dir_udp = opendir(".")) != NULL) {
                while ((d_udp = readdir(dir_udp)) != NULL) {
                    if (strlen(d_udp->d_name) > 4
                        && strcmp(&d_udp->d_name[strlen(d_udp->d_name) - 4], ".txt") == 0) { // è un file di testo
                        if ((fd_udp = open(d_udp->d_name, O_RDONLY)) >= 0) {
                            // leggo il primo carattere
                            if ((nread = read(fd_udp, &read_char, sizeof(char))) != 0) {
                                if (nread < 0) {
                                    sprintf(err, "(PID %d) impossibile leggere dal file", getpid());
                                    perror(err);
                                    ris_udp = -1;
                                    break;
                                } else {
                                    if (read_char < 'A' || read_char > 'Z') continue; // file non inizia con lettera maiuscola
                                }
                            }

                            // leggo i restanti caratteri
                            while ((nread = read(fd_udp, &read_char, sizeof(char))) != 0) {
                                if (nread < 0) {
                                    sprintf(err, "(PID %d) impossibile leggere dal file", getpid());
                                    perror(err);
                                    ris_udp = -1;
                                    break;
                                } else {
                                    if (read_char == req.car) curr_occ += 1;
                                    else if (read_char == '\n') {
                                        if (curr_occ > req.occ) ris_udp += 1;
                                        curr_occ = 0;
                                    }
                                }
                            }
                        }
                        close(fd_udp);
                    }
                }
                // invio risposta al client
                if (sendto(udp_sd, &ris_udp, sizeof(ris_udp), 0, (struct sockaddr *) &cliaddr, addrlen) < 0) {
                    perror("sendto ");
                    continue;
                }
            }
            closedir(dir_udp); // chiudo il direttorio*/
        }

        /* gestione richieste tcp */
        if (FD_ISSET(listen_sd, &rset)) {
            printf("Ricevuta richiesta TCP: trasferimento file con prefisso\n");

            addrlen = sizeof(cliaddr);
            if ((conn_sd = accept(listen_sd, (struct sockaddr *)&cliaddr, &addrlen)) < 0) {
                if (errno == EINTR) {
                    perror("Forzo la continuazione della accept");
                    continue;
                } else {
                    perror("Error in accept: ");
                    exit(6);
                }
            }

            if (fork() == 0) {
                // figlio
                close(listen_sd);

                // stampo le informazioni sul client
                hostTcp = gethostbyaddr((char *) &cliaddr.sin_addr, sizeof(cliaddr.sin_addr), AF_INET);
                if (hostTcp == NULL) {
                    printf("Server (figlio): host client e' %s\n", inet_ntoa(cliaddr.sin_addr));
                } else {
                    printf("Server (figlio): host client e' %s \n", hostTcp->h_name);
                }

                // leggo la richiesta del client
                while ((nread = read(conn_sd, prefisso, sizeof(prefisso))) > 0) { // leggo prefisso
                    printf("Server (figlio): prefisso inviato: %s\n", prefisso);

                    if ((dir_tcp = opendir(".")) != NULL) { // apertura direttorio corrente
                        while ((d_tcp = readdir(dir_tcp)) != NULL) {
                            if (strlen(d_tcp->d_name) > 4
                                && strcmp(&d_tcp->d_name[strlen(d_tcp->d_name) - 4], ".txt") == 0
                                && strncmp(d_tcp->d_name, prefisso, strlen(prefisso)) == 0) { // è un file di testo che inizia con prefisso
                                
                                if (write(conn_sd, d_tcp->d_name, (strlen(d_tcp->d_name) + 1)) < 0) { // invio nome file al client
                                    perror("write");
                                    break;
                                }

                                // ricezione file valido
                                if (read(conn_sd, &valid, sizeof(int)) >= 0) {
                                    printf("Valid: %d\n", valid);
                                    if (valid) {
                                        // invio file al client 
                                        if ((fd_tcp = open(d_tcp->d_name, O_RDONLY)) >= 0) {
                                            while((nread = read(fd_tcp, buff, sizeof(buff))) > 0) {
                                                if (write(conn_sd, buff, nread) < 0) {
                                                    perror("write"); 
                                                    break;
                                                }
                                            }
                                            write(conn_sd, &zero, 1); // Invio terminazione file: zero binario
                                        }
                                        close(fd_tcp);
                                    }
                                }
                            }
                        }
                    }
                    closedir(dir_tcp); // chiudo il direttorio
                }

                // Libero risorse
                printf("Figlio TCP terminato, libero risorse e chiudo. \n");
                close(conn_sd);
                exit(0);
            }
            close(conn_sd);
        }
    }
}