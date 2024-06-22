#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> 
#include <time.h>
#include <sys/wait.h>

int numOcc(int arr[], int arrLength, int n) {
    int occ = 0;
    for (int i = 0; i < arrLength; i++) {
        if (arr[i] == n) occ++;
    }
    return occ;
}

void main(int argc, char *argv[]) {
    if (argc == 3) {
        int fermate = atoi(argv[1]);
        int ultimoPiano = atoi(argv[2]);
        
        // create array fermate
        int fermateArr[fermate];
        srand(time(NULL));
        printf("Fermate: ");
        for (int i = 0; i < fermate; i++) {
            fermateArr[i] = rand() % (ultimoPiano + 1);
            printf("%d, ", fermateArr[i]); // print array fermate
        }
        printf("\n");

        // create childs
        for (int numPiano = 0; numPiano < ultimoPiano + 1; numPiano++) {
            int pid = fork();
            if (pid == 0) {
                // child
                int numFermate = numOcc(fermateArr, fermate, numPiano);
                exit(numFermate);
            } else if (pid > 0) {
            	// father
            	int status;
            	wait(&status);
            	printf("Terminazione del piano %d con pid %d e numero fermate %d\n", numPiano, pid, WEXITSTATUS(status));
            } else {
                printf("Error creating child");
                exit(1);
            }
        }
    } else {
        printf("Sono previsti 2 argomenti\n");
    }
}
