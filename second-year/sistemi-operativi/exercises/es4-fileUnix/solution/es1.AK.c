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
    int inq; //id inquinante
    int mcg;  //microgrammi per m^3
}concentrazione;

void P0_handler(int signo){
    char s[15];
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

    //leggo la somma che si trova in fondo al file
    if (lseek(fdin,-sizeof(int), SEEK_END)<0){
        perror("P0: Errore in lseek 1.\n");
        exit(EXIT_FAILURE);
    }
    int sum;
    if (read(fdin, &sum, sizeof(int))!=sizeof(int)){
        perror("P0: Errore nella lettura dell'ultimo valore da file temporaneo.\n");
        exit(EXIT_FAILURE);
    }else{
        sprintf(s,"AQI: %d\n",sum);
        printf("P0: Writing %s", s);
        write(fdout,s, strlen(s));
    }

    //leggo il valore di PM2.5
    if (lseek(fdin,2*sizeof(concentrazione), SEEK_SET)<0){
        perror("P0: Errore in lseek 2.\n");
        exit(EXIT_FAILURE);
    }
    concentrazione pm2;
    if (read(fdin, &pm2, sizeof(concentrazione))!=sizeof(concentrazione)){
        perror("P0: Errore nella lettura di PM 2.5 da file temporaneo.\n");
        exit(EXIT_FAILURE);
    }else{
        sprintf(s,"PM2.5: %d\n",pm2.mcg);
        printf("P0: Writing %s", s);
        write(fdout,s, strlen(s));
    }

    close(fdout);
    close(fdin);

    //una volta chiuso il file temporaneo fdin, posso cancellarlo come segue
    unlink(temp_filename);
}


int main(int argc, char* argv[]) {

    int pid1;
    concentrazione c;

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

    signal(SIGUSR1, P0_handler);
    pid1=fork();
    if (pid1==0){
        //creazione di un file binario temporaneo
        int ftemp = creat(temp_filename, 0644);
        int i,sum=0;
        srand(time(NULL));
        printf("File temporaneo:\n");
        for(i=0;i<5;i++){
            c.inq=i;
            c.mcg=rand()%101; // compreso tra 0 e 100
            write(ftemp, &c, sizeof(concentrazione));
            sum+=c.mcg;
            printf("%d: %d\n",c.inq,c.mcg);
        }
        //scrivo la somma degli inquinanti come ultimo elemento
        c.inq=i;
        c.mcg=sum;
        write(ftemp, &c, sizeof(concentrazione));
        printf("%d: %d\n",c.inq,c.mcg);
        //scrittura del file temporaneo terminata:
        kill(getppid(),SIGUSR1);
        close(ftemp);
    }else if (pid1>0){
        //P0 deve attendere che Ftemp sia stato creato da P1 prima di procedere.
        pause();
        //in alternativa al segnale era possibile usare la wait
        //in quanto si tratta del processo padre che deve attendere il figlio P1.
        exit(EXIT_FAILURE);
    }else{
        perror("Errore nella fork()\n");
        exit(EXIT_FAILURE);
    }
}

