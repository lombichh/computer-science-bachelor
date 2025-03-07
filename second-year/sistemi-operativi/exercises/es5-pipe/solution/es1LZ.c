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

        //Apre il file e legge il contenuto dalla fine all'inizio
        fd_in=open(argv[1], O_RDONLY);
        if (fd_in<0){
            perror("P1:Errore nell'apertura del file");
            exit(EXIT_FAILURE);
        }
        //Legge Fin al contrario e lo invia a P2
        lseek(fd_in, -sizeof(char), SEEK_END); //posiziona l'IO pointer sull'ultimo char del file
        do{
            nread=read(fd_in, &c, sizeof(char)); //legge un char e sposta l'IO pointer avanti di 1 (per leggere il successivo)
            if(nread<0){
                perror("P1:Errore nella lettura da file");
                exit(EXIT_FAILURE);
            }
        written=write(pp[1],&c, sizeof(char)); //scrive il char letto su pipe
            if(written!=1){
                perror("P1:Errore nella scrittura su pipe");
                exit(EXIT_FAILURE);
            }
        }while(lseek(fd_in, -2*sizeof(char), SEEK_CUR)>=0); //posiziona l'IO pointer sul char precedente all'ultimo letto
        close(pp[0]);
        close(fd_in);

        exit(EXIT_SUCCESS);
    }


    // creazione figlio P2:
    pid2 = fork(); 
    if ( pid2 < 0 ) {
        perror("P0: Impossibile creare P2");
        exit(EXIT_FAILURE);
    }else if ( pid2 == 0 ){
        //P2:
        //non scrive sulla pipe, quindi chiude pp[1]
        close(pp[1]);

        //P2: leggo dalla pipe e filtro le righe che iniziano per Car
        char Car=argv[2][0];

        int reading_first_char=1, starts_with_C=0;
        while((nread=read(pp[0], &c, sizeof(char)))>0){
            if (reading_first_char){
                if (c==Car){
                    starts_with_C=1;
                }
                reading_first_char=0;
            }
            if (starts_with_C){
                write(1,&c,sizeof(char));
            }
            if (c=='\n'){ 
                //se ho raggiunto il file-linea, il prossimo carattere è il primo della linea successiva
                reading_first_char=1;
                //resetto starts_with_C perchè ancora non so se la prossima linea inizia per C
                starts_with_C=0;
            }
        }
        if(nread<0){
            perror("P0:Errore nella lettura da pipe");
            exit(EXIT_FAILURE);
        }

        close(pp[0]);
        exit(EXIT_SUCCESS);
    }

    //P0: non legge ne scrive sulla pipe. Chiude entrambi gli estremi!
    close(pp[0]);
    close(pp[1]);
    exit(EXIT_SUCCESS);
    
}



void print_usage(char *prog_name){
    printf("Usage: %s FileName N\n", prog_name);
}