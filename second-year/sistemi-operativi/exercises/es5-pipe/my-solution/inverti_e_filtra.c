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

void main(int argv, char *argc[]) {
    if (argv != 3) {
        printf("2 arguments shold be passed\n");
        exit(EXIT_FAILURE);
    }

    // arguments
    char fin[20];
    char c;
    strcpy(fin, argc[1]);
    c = argc[2][0];

    // create pipe
    int fd[2];
    pipe(fd);

    // processes
    int pid1 = fork();
    if (pid1 == 0) {
        // P1
        close(fd[0]); // close read

        int fdin = open(fin, O_RDONLY);
        lseek(fdin, -sizeof(char), SEEK_END);

        char c;
        do {
            if (read(fdin, &c, sizeof(char)) < 0) {
                perror("Error reading from file\n");
                exit(EXIT_FAILURE);
            }
            if (!write(fd[1], &c, sizeof(char))) {
                perror("Error writing in pipe\n");
                exit(EXIT_FAILURE);
            }
        } while (lseek(fdin, -2 * sizeof(char), SEEK_CUR) >= 0);
        char endLineChar = '\n';
        write(fd[1], &endLineChar, sizeof(char));

        close(fd[1]); // close write
        close(fdin);

        printf("Exit 1\n");
        exit(EXIT_SUCCESS);
    } else if (pid1 < 0) {
        printf("Error creating P1");
        exit(EXIT_FAILURE);
    }

    int pid2 = fork();
    if (pid2 == 0) {
        // P2
        close(fd[1]); // close write

        char c;
        while (read(fd[0], &c, sizeof(char)) > 0) write(1, &c, sizeof(char));
        
        close(fd[0]); // close read

        printf("Exit 2\n");
        exit(EXIT_SUCCESS);
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