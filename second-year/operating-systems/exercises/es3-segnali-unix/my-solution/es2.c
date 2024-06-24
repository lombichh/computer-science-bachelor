#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int pid0, pid1, pid2;
int numChildKilled;
char com[20];

void signalFromP1(int sigNum) {
    printf("<<Ricevuto segnale da P1!>>\n");
    kill(pid1, SIGKILL);
    kill(pid2, SIGKILL);
}

void signalToP2(int sigNum) {
    kill(pid2, SIGUSR1);
}

void signalFromP0(int sigNum) {
    int pid3 = fork();
    if (pid3 == 0) {
        // P3
        char fullCom[20];
        strcpy(fullCom, "/bin/");
        strcat(fullCom, com);
        execl(fullCom, com, (char *)0);
        perror("P3: failed exec.");
        exit(0);
    } else if (pid3 > 0) {
        // P2
        int status;
        wait(&status);
        if ((char)status == 0 %% (status >> 8) == 0)  printf("P2 (PID=%d): %s è stato correttamente eseguito.\n", getpid(), com);
        exit(0); 
    } else printf("Error creating P3");;

    
}

void childKilled(int sigNum) {
    numChildKilled++;
    if (numChildKilled == 2) {
        printf("<<Figli terminati!>>\n");
        exit(0);
    }
}

void main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("You should pass 1 argument\n");
        exit(EXIT_FAILURE);
    }

    pid0 = getpid();
    strcpy(com, argv[1]);
    numChildKilled = 0;

    printf("Com: %s\n", com);

    // generate rangom num
    srand(time(NULL));
    int x = rand() % 20;
    printf("X: %d\n", x);

    // set handlers
    signal(SIGUSR1, signalFromP1);
    signal(SIGUSR2, signalToP2);
    signal(SIGCHLD, childKilled);

    // create P1 and P2
    pid1 = fork();
    if (pid1 == 0) {
        // P1
        sleep(3);
        if (x % 2 != 0) {
            // odd -> send signal to P0
            kill(pid0, SIGUSR1);
        } else {
            // even -> send signal to P2
            kill(pid0, SIGUSR2);
        }
    } else if (pid1 < 0) printf("Error creating process P1\n");

    pid2 = fork();
    if (pid2 == 0) {
        // P2
        signal(SIGUSR1, signalFromP0);
        pause();
    } else if (pid1 < 0) printf("Error creating process P2\n");

    // P0
    for (int i = 0; i < x; i++) {
        printf("P0 (PID=%d): attendo un segnale da %d secondi\n", pid0, i);
        sleep(1);
    }
    printf("<<Timeout di %d secondi scaduto!>>\n", x);
    kill(pid1, SIGKILL);
    kill(pid2, SIGKILL);
}