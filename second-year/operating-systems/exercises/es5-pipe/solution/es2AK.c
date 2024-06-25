#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>


void print_usage(char *prog_name);


int main(int argc, char* argv[]) {
    char c;
    int pp[2],pid,nread, fd_in, written;

    // controllo argomenti:
    if ( argc != 3 ) {
        fprintf(stderr, "Numero di parametri non valido\n");
        print_usage(argv[0]);
        exit(EXIT_FAILURE);
    }

    
    if (pipe(pp)<0) {
        perror("Errore nella creazione della pipe");
        exit(EXIT_FAILURE); 
    }

    // creazione figlio:
    pid = fork(); 
    if ( pid < 0 ) {
        perror("P0: Impossibile creare P1");
        exit(EXIT_FAILURE);
    }else if ( pid == 0 ){
        close(pp[0]); // il figlio non legge dalla pipe, quindi chiude pp[0]

        
        //Legge Fin al contrario usando il comando rev e lo invia a P0
        //non occorre aprire il file perchè ci penserà rev
        //devo solo collegare l'out di rev al lato di scrittura della pipe

        close(1);
        dup(pp[1]);
        execlp("rev","rev",argv[1],(char*)0);
        perror("P1:Errore nella exec di rev");
        exit(EXIT_FAILURE);
    }else{
        close(pp[1]); // il padre non scrive sulla pipe, quindi chiude pp[1]
        printf("P0: Creato figlio  con pid %d\n", pid); 
        //P0: leggo dalla pipe e filtro le righe che iniziano per Car usando il comando grep
        //mi occorre una variabile in cui memorizzare la stringa di filtraggio (^+Car) da passare alla execlp 
        char filtro[3];
        filtro[0]='^';
        filtro[1]=argv[2][0];
        filtro[2]='\0'; //la stringa deve essere ben formata: deve terminare col terminatore di stringa
        
        close(0);
        dup(pp[0]);

        execlp("grep","grep",filtro,(char*)0);
        perror("P0:Errore nella exec di grep");
        exit(EXIT_FAILURE);
    }
    
}



void print_usage(char *prog_name){
    printf("Usage: %s FileName Car\n", prog_name);
}