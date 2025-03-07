#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>


void print_usage(char *prog_name);
void wait_child();


int main(int argc, char* argv[]) {
    char c;
    int pp[2],pid1, pid2,nread, fd_in, written;

    // controllo argomenti:
    if ( argc != 3 ) {
        fprintf(stderr, "Numero di parametri non valido\n");
        print_usage(argv[0]);
        exit(EXIT_FAILURE);
    }
    int N=atoi(argv[2]);
    if ( N<0){
        fprintf(stderr, "N deve essere un intero > 0\n");
        print_usage(argv[0]);
        exit(EXIT_FAILURE);
    }

    
    if (pipe(pp)<0) {
        perror("Errore nella creazione della pipe");
        exit(EXIT_FAILURE); 
    }


    // creazione figlio P1:
    pid1 = fork(); 
    if ( pid1 < 0 ) {
        perror("P0: Impossibile creare P1");
        exit(EXIT_FAILURE);
    }else if ( pid1 == 0 ){
        //P1:
        //non legge dalla pipe, quindi chiude pp[0]
        close(pp[0]);

        //Apre il file e legge il contenuto dalla fine all'inizio usando il comando rev e lo invia a P2
        //non occorre aprire il file perchè ci penserà rev
        //devo solo collegare l'out di rev al lato di scrittura della pipe

        close(1);
        dup(pp[1]);
        execlp("rev","rev",argv[1],(char*)0);
        perror("P0:Errore nella exec di rev");
        exit(EXIT_FAILURE);
    }


    // creazione figlio P2:
    pid2 = fork(); 
    if ( pid2 < 0 ) {
        perror("P0: Impossibile creare P2");
        exit(EXIT_FAILURE);
    }else if ( pid2 == 0 ){
        //P2: non scrive sulla pipe, quindi chiude pp[1]
        close(pp[1]);
        //P2: leggo dalla pipe e filtro le righe che iniziano per Car usando il comando grep
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

    //P0: non legge ne scrive sulla pipe. Chiude entrambi gli estremi!
    close(pp[0]);
    close(pp[1]);

    wait_child();
    wait_child();

    exit(EXIT_SUCCESS);
    
}


void wait_child(){
    int status, pid_terminated=wait(&status);
    if ((char)status==0) 
        printf("P0: figlio con PID=%d terminato volontariamente con stato %d.\n",pid_terminated, status>>8);
    else 
        printf("P0: figlio con PID=%d terminato involontariamente per segnale %d\n",pid_terminated,(char)status);
}


void print_usage(char *prog_name){
    printf("Usage: %s FileName N\n", prog_name);
}