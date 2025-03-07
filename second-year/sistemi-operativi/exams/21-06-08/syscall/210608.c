#include <stdio.h>
#include <fcntl.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>
#include <ctype.h>

#define DIM 255

// esame Fin S N

int contiene_cifre(char string[]);
void wait_child();

int main(int argc, char* argv[])
{
    char Fin[DIM], S[DIM];
    int fd;
    int p0p1[2];
    int p1p2[2];
    int N, V;
    char buf[DIM];
    int k, i;

    // controllo argomenti:
    if(argc != 4) {
        printf("Numero di argomenti errato!\n");
        exit(1);
    }

    if(argv[1][0] != '/') {
        printf("Fin non è un nome assoluto!\n");
        exit(1);
    }
    strcpy(Fin, argv[1]);

    fd = open(Fin, O_RDONLY);
    if(fd < 0) {
        printf("Fin non può essere aperto!\n");
        exit(-1);
    }
    close(fd);

    k = contiene_cifre(argv[2]);
    if(k == 1) {
        printf("S contiene cifre!\n");
        exit(-2);
    }
    strcpy(S, argv[2]);

    N = atoi(argv[3]);
    if(N <= 0) {
        printf("N è un valore non positivo\n");
        exit(-3);
    }

    printf("Esecuzione: %s %s %s %d\n", argv[0], Fin, S, N);

    if(pipe(p0p1) < 0) { // pipe per la comunicazione p0->p1
        printf("apertura Pipe p0p1 fallita");
        exit(-4);
    }

    // P0 crea P1:
    int pidP1 = fork();
    if(pidP1 == 0) {         // figlio P1
        if(pipe(p1p2) < 0) { // pipe per la comunicazione p1->p2
            printf("apertura Pipe p1p2 fallita");
            exit(-4);
        }
        int pidP2 = fork(); // creazione P2
        if(!pidP2) {
            // CODICE P2:
            close(p0p1[0]);
            close(p0p1[1]);
            close(p1p2[1]); // chiudo lato della pipe di scrittura
            i = 0;
            while((k = read(p1p2[0], &buf[i], sizeof(char))) > 0)
                i++;

            buf[i] = '\n';
            printf("P2: stringa ricevuta da P1: %s\n", buf);
            V = atoi(buf);
            printf("P2: valore ricevuto da P1: %d\n", V);

            if(V > N) {
                printf("Trovate %d righe contenenti la stringa %s\n", V, S);
                exit(0);
            } else {
                printf("Le righe contenenti la stringa %s sono troppo poche\n", S);
                sleep(5);
                unlink(Fin);
                exit(1);
            }
            close(p1p2[0]);
            // fine P2
        } else { // P1
            // CODICE P1:
            close(p1p2[0]);
            close(p0p1[1]);
            close(0); // chiusura stdin
            dup(p0p1[0]); // redirezione lato di lettura p0p1 sullo STDIN
            close(1); // chiusura stdout
            dup(p1p2[1]); // redirezione lato di scrittura p1p2 sullo STDOUT
            close(p0p1[0]);
            close(p1p2[1]);

            execlp("grep", "grep", "-c", S, NULL); // esecuzione grep S con opzione -c
            perror("Errore grep!");
            exit(-5);
        }

    } else {
        // CODICE P0:
        close(p0p1[0]);
        fd = open(Fin, O_RDONLY);
        char c;

        while(read(fd, &c, sizeof(char)) > 0) {
            k = isdigit(c);
            if(k == 0) // scarto le cifre decimali
                write(p0p1[1], &c, sizeof(char));
        }
        close(fd);
        close(p0p1[1]);
        wait_child();
        exit(0);
    }
}

int contiene_cifre(char string[])
{
    int i;
    for(i = 0; i < DIM && string[i] != '\0'; i++) {
        if(isdigit(string[i]))
            return 1;
    }
    return 0;
}

void wait_child()
{
    int pid_terminated, status;
    pid_terminated = wait(&status);
    if(WIFEXITED(status))
        printf("\nP0: terminazione volontaria del figlio %d con stato %d\n", pid_terminated, WEXITSTATUS(status));
    else if(WIFSIGNALED(status))
        printf(
            "\nP0: terminazione involontaria del figlio %d a causa del segnale %d\n", pid_terminated, WTERMSIG(status));
}
