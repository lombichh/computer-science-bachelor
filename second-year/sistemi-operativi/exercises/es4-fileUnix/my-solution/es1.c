#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <time.h>


char fTemp[20], fOut[20];

typedef struct {
    int id;
    int energy;
} consumo;

void writeOut(int maxId) {
    // read max from fTemp
    int fdTemp = open(fTemp, O_RDONLY);
    lseek(fdTemp, maxId * sizeof(consumo), 0);
    consumo maxCons;
    read(fdTemp, &maxCons, sizeof(consumo));

    // write max in fOut
    int fdOut = open(fOut, O_WRONLY|O_CREAT|O_TRUNC, 0777);
    char s[200];
    sprintf(s, "core: %d\nenergy: %d", maxCons.id, maxCons.energy);
    write(fdOut, s, strlen(s));

    close(fdTemp);
    close(fdOut);
    unlink(fTemp);
}

void max0(int sigId) {writeOut(0);}

void max1(int sigId) {writeOut(1);}

void max2(int sigId) {writeOut(2);}

void main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("2 arguments should be passed\n");
        exit(EXIT_FAILURE);
    }

    // arguments
    strcpy(fTemp, argv[1]);
    strcpy(fOut, argv[2]);

    // signal handlers
    signal(SIGUSR1, max0);
    signal(SIGUSR2, max1);
    signal(SIGALRM, max2);

    int pid0 = getpid();
    int pid1 = fork();
    if (pid1 == 0) {
        // P1
        int fdTemp = creat(fTemp, 0777);

        // write fTemp
        srand(time(NULL));
        int maxId = 0;
        int maxEnergy = -1;
        for (int id = 0; id < 3; id++) {
            // generate consumo
            consumo cons;
            cons.id = id;
            cons.energy = rand() % 100;

            // write consumo in fTemp
            write(fdTemp, &cons, sizeof(consumo));
            printf("Id: %d; Energy: %d\n", cons.id, cons.energy);

            // update max
            if (cons.energy > maxEnergy) {
                maxId = cons.id;
                maxEnergy = cons.energy;
            }
        }
        close(fdTemp);

        // signal max
        if (maxId == 0) kill(pid0, SIGUSR1);
        else if (maxId == 1) kill(pid0, SIGUSR2);
        else kill(pid0, SIGALRM);

        exit(0);
    } else if (pid1 > 0) {
        // P0
        pause();
    } else printf("Error creating P1");
}