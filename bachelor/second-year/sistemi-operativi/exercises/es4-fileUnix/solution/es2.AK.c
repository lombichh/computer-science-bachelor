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

    //LEGGO L'ULTIMA RIGA SALTANDO LE ALTRE. 
    //Poichè non so quanti caratteri ci sono in ogni riga, 
    //devo leggere a ritroso carattere per carattere finchè non trovo un '\n'

    //mi posiziono sull'ultimo char
    if (lseek(fdin,0, SEEK_END)<0){
        perror("P0: Errore in lseek 1.\n");
        exit(EXIT_FAILURE);
    }
    //leggo a ritroso
    //printf("Lettura a ritroso\n");
    char c;
    do{
        //per leggere il char precedente devo andare indietro di 2 char.
        //alla prima iterazione questo mi permette anche di saltare l'ultimo char che è \n
        if (lseek(fdin,-2*sizeof(char), SEEK_CUR)<0){
            perror("P0: Errore in lseek 2.\n");
            exit(EXIT_FAILURE);
        }   
        //leggo un char (l'IO pointer si sposta avanti di 1 char)
        read(fdin,&c,sizeof(char));
        //printf("%c",c);
    }while(c!='\n'); 

    printf("\n");

    //ora l'IO pointer si trova all'inizio dell'ultima riga. 
    //Leggo i due interi separati da ';'
    char buff[10];
    int i=0;
    concentrazione sum;

    while(read(fdin,&buff[i],sizeof(char))>0){
        //printf("buff[i]=%c\n",buff[i]);
        if (buff[i]==';'){
            buff[i]='\0'; //NB: il terminatore di stringa è necessario per il corretto funzionamento della atoi
            sum.inq = atoi(buff);
            printf("sum.inq=%d\n",sum.inq);
            i=0;
        } else if (buff[i]=='\n') {
            buff[i]='\0';
            sum.mcg = atoi(buff);
            printf("sum.mcg=%d\n",sum.mcg);
        }else
            i++;
    }
    


    //STAMPO SU FILE BINARIO:
    if (write(fdout, &sum, sizeof(concentrazione))!=sizeof(concentrazione)){
        perror("P0: Errore nella scrittura della somma su file di output.\n");
        exit(EXIT_FAILURE);
    }

    
    //LEGGO il valore del PM2.5
    //non esiste modo di saltare alla terza riga perchè non so di quanti char è composto ciascun intero. 
    //Pertanto, devo leggere tutti i char da inizio file fino alla terza riga

    //mi posiziono a inizio file:
    if (lseek(fdin,0, SEEK_SET)<0){
        perror("P0: Errore in lseek 3.\n");
        exit(EXIT_FAILURE);
    }
    //inizio a leggere char per char. Scarto quanto letto fino a raggiungere la terza riga:
    int line=0;
    while (line<2){
        if(read(fdin,&c,sizeof(char))!=sizeof(char)){
            perror("P0: Errore nella lettura da file temporaneo.\n");
            exit(EXIT_FAILURE);
        }else{
            if(c=='\n'){
                line++;
            }
        }
    }
    //ora l'IO pointer si trova all'inizio della terza riga

    
    //leggo il primo intero della terza riga:
    concentrazione pm2;
    i=-1;
    do{
        i++;
        read(fdin,&buff[i],sizeof(char));
    }while(buff[i]!=';');
    buff[i]='\0';
    pm2.inq=atoi(buff);
    printf("pm2.inq=%d\n",pm2.inq);
            
    //leggo il secondo intero della terza riga:
    i=-1;
    do{
        i++;
        read(fdin,&buff[i],sizeof(char));
    }while(buff[i]!='\n');
    buff[i]='\0';
    pm2.mcg=atoi(buff);
    printf("pm2.mcg=%d\n",pm2.mcg);
    

    //STAMPO SU FILE BINARIO:
    if (write(fdout, &pm2, sizeof(concentrazione))!=sizeof(concentrazione)){
        perror("P0: Errore nella scrittura del PM2.5 su file di output.\n");
        exit(EXIT_FAILURE);
    }

    close(fdout);
    close(fdin);

    //una volta chiuso il file temporaneo fdin, posso cancellarlo come segue
    //unlink(temp_filename);
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
        //creazione di un file di testo temporaneo
        int ftemp = creat(temp_filename, 0644);
        int i,sum=0;
        char buff[10];
        srand(time(NULL));
        printf("File temporaneo:\n");
        for(i=0;i<5;i++){
            c.inq=i;
            c.mcg=rand()%101; // compreso tra 0 e 100
            sprintf(buff,"%d;%d\n",c.inq,c.mcg);
            write(ftemp, buff, strlen(buff));
            sum+=c.mcg;
            printf("%d: %d\n",c.inq,c.mcg);
        }
        //scrivo la somma degli inquinanti come ultimo elemento
        c.inq=i;
        c.mcg=sum;
        sprintf(buff,"%d;%d\n",c.inq,c.mcg);
        write(ftemp, buff, strlen(buff));
        printf("%d: %d\n",c.inq,c.mcg);

        //scrittura del file temporaneo terminata. Notifico P0
        kill(getppid(),SIGUSR1);
        close(ftemp);
    }else if (pid1>0){
        //P0 deve attendere che Ftemp sia stato creato da P1 prima di procedere.
        pause();
        //in alternativa al segnale era possibile usare la wait, 
        //in quanto si tratta per processo padre che deve attendere il figlio P1.
        exit(EXIT_FAILURE);
    }else{
        perror("Errore nella fork()\n");
        exit(EXIT_FAILURE);
    }
}

