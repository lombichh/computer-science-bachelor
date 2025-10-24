#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <ctype.h>
#include <string.h>
#include <sys/stat.h>

void wait_child();

void main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("2 arguments shold be passed\n");
        exit(EXIT_FAILURE);
    }

    // arguments
    char fin[20];
    char c;
    strcpy(fin, argv[1]);
    c = argv[2][0];

    // create pipe
    int fd[2];
    pipe(fd);

    // processes
    int pid1 = fork();
    if (pid1 == 0) {
        // P1
        close(fd[0]); // close read
        close(1);
        dup(fd[1]); // write in standard output

        execl("/bin/rev", "rev", fin, (char *)0);
        perror("Error in rev exec\n");
        exit(EXIT_FAILURE);
    } else if (pid1 < 0) {
        printf("Error creating P1");
        exit(EXIT_FAILURE);
    }

    int pid2 = fork();
    if (pid2 == 0) {
        // P2
        close(fd[1]); // close write
        close(0);
        dup(fd[0]); // read in standard input

        char filter[3];
        filter[0] = '^';
        filter[1] = c;
        filter[2] = '\0';

        execl("/bin/grep", "grep", filter, (char *)0);
        perror("Error in grep exec\n");
        exit(EXIT_FAILURE);
    } else if (pid2 < 0) {
        printf("Error creating P2");
        exit(EXIT_FAILURE);
    }

    close(fd[0]);
    close(fd[1]);

    for (int i = 0; i < 2; i++) {
        int status, pid_terminated=wait(&status);
        if ((char)status==0) 
            printf("P0: figlio con PID=%d terminato volontariamente con stato %d.\n",pid_terminated, status>>8);
        else 
            printf("P0: figlio con PID=%d terminato involontariamente per segnale %d\n",pid_terminated,(char)status);
    }

    exit(EXIT_SUCCESS);
}