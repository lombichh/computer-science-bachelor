/*
 * Matricola: 0001071217
 * Nome: Matteo
 * Cognome: Lombardi
 * Compito: 2
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
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define DIM_BUFF 100
#define LENGTH_FILE_NAME 20
#define max(a, b) ((a) > (b) ? (a) : (b))

typedef struct {
    char nome_dir[LENGTH_FILE_NAME];
    char car;
    int occ;
} Request;

int conta_file(char *name) {
    DIR           *dir;
    struct dirent *dd;
    int            count = 0;
    dir                  = opendir(name);
    if (dir == NULL)
        return -1;
    while ((dd = readdir(dir)) != NULL) {
        printf("Trovato il file %s\n", dd->d_name);
        count++;
    }
    printf("Numero totale di file %d\n", count);
    closedir(dir);
    return count;
}

void gestore(int signo) {
    int stato;
    printf("esecuzione gestore di SIGCHLD\n");
    wait(&stato);
}

int main(int argc, char **argv) {
    int listenfd, connfd, udpfd, nread, nready, maxfdp1;
    const int on = 1;
    fd_set rset;
    int len, port;
    struct sockaddr_in cliaddr, servaddr;

    /* controllo argomenti */
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

    /* iniziailizzazione indirizzo server */
    memset((char *) &servaddr, 0, sizeof(servaddr));
    servaddr.sin_family      = AF_INET;
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port        = htons(port);

    printf("Server avviato\n");

    /* creazione socket tcp */
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

    /* creazione socket udp */
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

    /* aggancio gestore per evitare figli zombie */
    signal(SIGCHLD, gestore);

    len = sizeof(struct sockaddr_in);

    /* pulizia e settaggio maschera dei file descriptor */
    FD_ZERO(&rset);
    maxfdp1 = max(listenfd, udpfd) + 1;

    // variabili
    int nwrite, num;
    char zero = 0, buff[DIM_BUFF], nome_dir[LENGTH_FILE_NAME];
    int num_file;
    struct stat stat;

    Request req;
    DIR *dir;
    struct dirent *dd;
    int fd, currOcc, ris;
    char read_char;
    char nome_file[LENGTH_FILE_NAME];

    /* ciclo di ricezione eventi dalla select */
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

        if (FD_ISSET(listenfd, &rset)) { // client stream -> trasferimento file binari
            printf("Ricevuta richiesta da client stream: trasferimento file binari\n");
            len = sizeof(struct sockaddr_in);
            if ((connfd = accept(listenfd, (struct sockaddr *) &cliaddr, &len)) < 0) {
                if (errno == EINTR)
                    continue;
                else {
                    perror("accept");
                    exit(9);
                }
            }

            if (fork() == 0) { // processo figlio che serve la richiesta di operazione
                close(listenfd);
                printf("Dentro il figlio, pid=%i\n", getpid());

                // ricezione parametri
                while((nread = read(connfd, &nome_dir, sizeof(nome_dir))) > 0) {
                    printf("Direttorio richiesto %s\n", nome_dir);

                    // esecuzione richiesta
                    if ((dir = opendir(nome_dir)) != NULL) {
                        // conteggio file binari
                        num_file = 0;
                        while ((dd = readdir(dir)) != NULL) {
                            if (strcmp(dd->d_name, ".") != 0
                                && strcmp(dd->d_name, "..") != 0
                                && strcmp(&dd->d_name[strlen(dd->d_name - 4)], ".txt") != 0)
                                num_file++;
                        }
                        if (write(connfd, &num_file, sizeof(num_file)) < 0) {
                            perror("write");
                            break;
                        }

                        // invio file binari
                        while ((dd = readdir(dir)) != NULL) {

                            if (strcmp(dd->d_name, ".") != 0
                                && strcmp(dd->d_name, "..") != 0
                                && strcmp(&dd->d_name[strlen(dd->d_name - 4)], ".txt") != 0) {
                                printf("Invio file %s\n", dd->d_name);

                                if ((fd = open(dd->d_name, O_RDONLY)) < 0) {
                                    perror("open file");
                                    exit(1);
                                } else {
                                    if (write(connfd, &dd->d_name, (strlen(dd->d_name) + 1)) < 0) { // invio nome file
                                        perror("write");
                                        exit(1);
                                    }
                                    fstat(fd, &stat);
                                    if (write(connfd, &stat.st_size, sizeof(stat.st_size)) < 0) { // invio nome file
                                        perror("write");
                                        exit(1);
                                    }

                                    // invio contenuto file
                                    while ((nread = read(connfd, &read_char, sizeof(char))) > 0) {
                                        write(connfd, &read_char, 1);
                                    }
                                    printf("File %s inviato\n", dd->d_name);
                                    close(fd);
                                }
                            }
                        }
                        closedir(dir);
                    }
                }

                close(connfd); 
                exit(0); // Chiusura della connessione all'uscita dal ciclo
            }
            close(connfd); // Padre: chiusura socket di comunicazione
        }

        if (FD_ISSET(udpfd, &rset)) { // client datagram -> conteggio linee con occorrenze
            printf("Ricevuta richiesta da client datagram: conteggio linee con occorrenze\n");

            // ricezione parametri
            if (recvfrom(udpfd, &req, sizeof(Request), 0, (struct sockaddr *) &cliaddr, &len) < 0) {
                perror("recvfrom");
                continue;
            }
            
            // esecuzione richiesta
            ris = 0;
            dir = opendir(req.nome_dir);
            if (dir == NULL) ris = -1;

            while ((dd = readdir(dir)) != NULL) {
                if (strcmp(dd->d_name, ".") != 0 && strcmp(dd->d_name, "..") != 0) {
                    nome_file[0] = '\0';
                    strcat(nome_file, req.nome_dir);
                    strcat(nome_file, "/");
                    strcat(nome_file, dd->d_name);

                    printf("Analizzo file %s\n", nome_file);
                    
                    currOcc = 0;
                    if ((fd = open(nome_file, O_RDONLY)) < 0) {
                        perror("open file sorgente");
                        ris = -1;
                        break;
                    } else {
                        while ((nread = read(fd, &read_char, sizeof(char))) != 0) {
                            if (nread < 0) {
                                perror("lettura file");
                                ris = -1;
                                break;
                            } else {
                                if (read_char == req.car) {
                                    currOcc++;
                                    if (currOcc >= req.occ) ris++;
                                } else if (read_char == '\n') currOcc = 0;
                            }
                        }
                        close(fd);
                    }
                }
            }
            closedir(dir);

            // invio risultato
            if (sendto(udpfd, &ris, sizeof(ris), 0, (struct sockaddr *) &cliaddr, len) < 0) {
                perror("sendto");
                continue;
            }
        }
    }
}