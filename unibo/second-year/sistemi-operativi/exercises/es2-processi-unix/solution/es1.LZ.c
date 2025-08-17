#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <time.h>

#define MAXfermate 50 
#define MAXpiani 10

int M[MAXfermate],fer,ultimo,pid[MAXpiani];

void figlio(int indice);
int cerca_indice(int p);

int main(int argc, char *argv[]) {
int i, j, k, status, p; 


if (argc!=3)
{   printf("%s: sintassi sbagliata - 2 argomenti interi (fermate e ultimoPiano) \n", argv[0]);
    exit(1);
}

fer = atoi(argv[1]);
if (fer>MAXfermate){
    printf("%s: errore - il primo parametro deve essere minore o uguale a %d!\n", argv[0], MAXfermate);
    exit(1);
}
ultimo = atoi(argv[2]);
if (ultimo>MAXpiani){
    printf("%s: errore - il secondo parametro deve essere minore o uguale a %d!\n", argv[0], MAXpiani);
    exit(1);
}

srand(time(NULL));
for ( i=0; i<fer; i++ ) {
   M[i]=rand()%(ultimo+1); // compenso tra 0 e ultimo
}

// stampa vettore:
printf("\n----- DATI -----\n");
for ( i=0; i<fer; i++ ) {
    printf(" %d", M[i]);
}
printf("\n");
printf("----------------\n\n");


for ( i=0; i<=ultimo; i++ ) { // creazione figli
    pid[i] = fork();
    if ( pid[i] == 0 ) { // Eseguito dai figli
        figlio(i);
    }
    else if ( pid[i] > 0 ) { // Eseguito dal padre
        printf("Padre (PID=%d): ho creato il figlio %d (PID %d)\n", getpid(),i, pid[i]);
    }
    else {
        perror("Fork error:");
        exit(1);
    }
    

}

for ( i=0; i<=ultimo; i++ ) { // attesa figli
    p=wait(&status);
    k=cerca_indice(p); // ricerca indice del figlio con pid p
    if ((char)status==0) 
        printf("Il processo PID=%d ha calcolato che l'ascensore si è fermato %d volte al piano %d\n",p, status>>8, k);
    else 
        printf("Il processo PID=%d ha subito una term. involontaria  per segnale %d\n",p,(char)status);
}

/*************************
NB: Si noti che fork e wait sono state posizionate in 2 cicli for diversi. 
A tempo di esecuzione questa scelta fa sì che P0 crei come prima cosa tutti i figli 
e poi attenda la terminazione di ciascuno. 
Quindi in ogni momento possiamo avere in esecuzione contemporaneamente P0 e tutti i figli

Se invece avessimo fatto:
for ( i=0; i<=ultimo; i++ ) { // creazione figli
    pid[i] = fork();
    if ( pid[i] == 0 ) { // Eseguito dai figli
        ...
    }
    else if ( pid[i] > 0 ) { // Eseguito dal padre
        printf("Padre (PID=%d): ho creato il figlio %d (PID %d)\n", getpid(),i, pid[i]);
        p=wait(&status);
        .....
    }
    else {....}
}
Il padre P0 avrebbe creato un figlio e poi atteso la sua terminazione prima di creare il figlio successivo
Questa soluzione avrebbe limitato la concorrenza. In ogni momento avremmo avuto in esecuzione 
al massimo due processi: P0 e uno dei figli.
*************************/


}

void figlio(int indice) //il figlio i-esimo conta le occorrenze del voto i
{   int  j;
    int somma=0;

    for(j=0;j<fer; j++)
        if (M[j]==indice) 
            somma++;
    
    exit(somma);
}

int cerca_indice(int p){
    int i;
    for(i=0;i<=ultimo; i++)
        if (pid[i]==p)
            return i;
    return 0;
}

