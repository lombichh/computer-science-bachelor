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
    int lines_to_skip;
    switch (signo) {
        case SIGALRM:
            lines_to_skip=0;
            break;
        case SIGUSR1:
            lines_to_skip=1;
            break;
        case SIGUSR2:
            lines_to_skip=2;
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

    //Non posso saltare alla riga che riporta l'elemento maggiore con una lseek 
    //perchè (trattandosi di un file di testo) non so quanti caratteri ci sono su ogni riga

    //Leggo carattere per carattere fino alla riga lines_to_skip
    int line_traker=0;
    char c;
    while (line_traker<lines_to_skip){
        read(fdin, &c, sizeof(char));
        if (c=='\n')
            line_traker++;
    }
    
    //Leggo id e consumo del core più energivoro
    char buff[15];
    int i=0;
    consumo cons; //memorizzo qui il consumo massimo
    printf("PO: Leggo il massimo:\n");
    while(read(fdin, &buff[i], sizeof(char))>0){
        if (buff[i]==';'){
            buff[i]='\0';
            cons.id = atoi(buff);
            i=0;
        }else if (buff[i]=='\n'){
            buff[i]='\0';
            cons.energy = atoi(buff);
            break;
        }else
            i++;
    }

    //Scrivo il massimo su Fout
    printf("P0: Writing on Fout:\n%d: %d\n", cons.id, cons.energy);
    write(fdout,&cons, sizeof(consumo));


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
        //creazione di un file di testo temporaneo
        int ftemp = creat(temp_filename, 0644);
        int i, max=0, idmax=-1;
        srand(time(NULL));
        printf("File temporaneo:\n");
        char s[200];
        for(i=0;i<3;i++){
            c.id=i;
            c.energy=rand()%101; // compreso tra 0 e 100
            sprintf(s,"%d;%d\n",c.id,c.energy);
            write(ftemp, &s, strlen(s));
            printf("%s",s);
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

        
    }else if (pid1>0){
        //P0 deve attendere un segnale da P1 prima di procedere.
        pause();
        exit(EXIT_FAILURE);
    }else{
        perror("Errore nella fork()\n");
        exit(EXIT_FAILURE);
    }
}

