#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <time.h>
#include <signal.h>


#define MAX_FILENAME 20

char temp_filename[MAX_FILENAME],fout[MAX_FILENAME];

typedef struct{
    int id; //id core
    int energy;  //Wh consumati
}consumo;

void P0_handler(int signo){
    int elements_to_skip;
    switch (signo) {
        case SIGALRM:
            elements_to_skip=0;
            break;
        case SIGUSR1:
            elements_to_skip=1;
            break;
        case SIGUSR2:
            elements_to_skip=2;
            break;
        default:
            perror("Segnale inatteso\n");
            exit(EXIT_FAILURE);
        }

    //apertura del file temp
    int fdin=open(temp_filename, O_RDONLY);
    if(fdin < 0){
        perror("P0: Errore nell'apertura del file temporaneo.\n");
        exit(EXIT_FAILURE);
    }
    //apertura del file di output
    int fdout=open(fout, O_WRONLY|O_CREAT|O_TRUNC, 0644);
    if(fdout < 0){
        perror("Errore nell'apertura del file di output.\n");
        exit(EXIT_FAILURE);
    }

    //Salto all'elemento maggiore 
    if (lseek(fdin,elements_to_skip*sizeof(consumo), SEEK_SET)<0){
        perror("P0: Errore in lseek.\n");
        exit(EXIT_FAILURE);
    }

    //Leggo l'elemento maggiore
    consumo cons;
    if (read(fdin, &cons, sizeof(consumo))!=sizeof(consumo)){
        perror("P0: Errore nella lettura dell'elemento maggiore da file temporaneo.\n");
        exit(EXIT_FAILURE);
    }else{
        char s[200];
        sprintf(s,"core: %d\nenergy: %d\n",cons.id,cons.energy);
        printf("P0: Writing on Fout:\n%s", s);
        write(fdout,s, strlen(s));
    }

    close(fdout);
    close(fdin);

    //una volta chiuso il file temporaneo fdin, posso cancellarlo come segue
    unlink(temp_filename);
}


int main(int argc, char* argv[]) {

    int pid1;
    consumo c;

    /*controllo parametri in ingresso*/
    if ( argc != 3 ) {
        perror("Numero di parametri non valido.");
        exit(EXIT_FAILURE);
    }
    /*if (argv[1][0]!='/'){ 
        //se il parametro passato non inizia per '/' allora non è un nome assoluto
        perror("il primo parametro deve essere il nome assoluto di un file.");
        exit(EXIT_FAILURE);
    }
    if (argv[2][0]!='/'){ 
        perror("il secondo parametro deve essere il nome assoluto di un file.");
        exit(EXIT_FAILURE);
    }*/

    strcpy(temp_filename,argv[1]);
    strcpy(fout,argv[2]);

    signal(SIGALRM, P0_handler);
    signal(SIGUSR1, P0_handler);
    signal(SIGUSR2, P0_handler);
    pid1=fork();
    if (pid1==0){
        //creazione di un file binario temporaneo
        int ftemp = creat(temp_filename, 0644);
        int i, max=0, idmax=-1;
        srand(time(NULL));
        printf("File temporaneo:\n");
        for(i=0;i<3;i++){
            c.id=i;
            c.energy=rand()%101; // compreso tra 0 e 100
            write(ftemp, &c, sizeof(consumo));
            printf("%d: %d\n",c.id,c.energy);
            //tengo traccia del core più energivoro
            if (c.energy>max){
                max=c.energy;
                idmax=c.id;
            }
        }
        close(ftemp);

        //segnalo a P0 il core più energivoro:
        switch (idmax) {
        case 0:
            kill(getppid(),SIGALRM);
            break;
        case 1:
            kill(getppid(),SIGUSR1);
            break;
        case 2:
            kill(getppid(),SIGUSR2);
            break;
        default:
            perror("Id core inatteso\n");
            exit(EXIT_FAILURE);
        }
        //in alternativa ai segnali era possibile usare la wait 
        //in quanto si tratta del processo padre che deve attendere il figlio P1.
        //per discriminare il core più energivoro si potevano
        //usare 3 diversi valori di ritorno nella exit del figlio

        
    }else if (pid1>0){
        //P0 deve attendere un segnale da P1 prima di procedere.
        pause();
        exit(EXIT_FAILURE);
    }else{
        perror("Errore nella fork()\n");
        exit(EXIT_FAILURE);
    }
}

