#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <time.h>


void wait_child();

int main(int argc, char *argv[]) {
int piano,i,p1; 


if (argc!=3)
{   printf("%s: sintassi sbagliata - 2 argomenti \n", argv[0]);
    exit(1);
}

if (argv[1][0]!='/'){
    printf("%s: errore - il primo parametro deve essere il nome ASSOLUTO di un file!\n", argv[0] );
    exit(1);
}

piano = atoi(argv[2]);
if (piano<0){
    printf("%s: errore - il secondo parametro deve essere un intero positivo!\n", argv[0] );
    exit(1);
}


p1=fork(); //creazione unico figlio
if ( p1 == 0 ) { // Eseguito dai figli
     execlp("grep","grep","-c",argv[2], argv[1], (char*)0);
     perror("Errore nell'invocazione della grep");
     exit(1);
}else if ( p1 > 0 ) { // Eseguito dal padre
    printf("Padre (PID=%d): ho creato il figlio (PID %d)\n", getpid(),p1);
    wait_child();
}
else {
    perror("Fork error:");
    exit(1);
}


}

void wait_child(){
    int status, pid_terminated=wait(&status);
    if ((char)status==0) 
        printf("P0: figlio con PID=%d terminato volontariamente con stato %d.\n",pid_terminated, status>>8);
    else 
        printf("P0: figlio con PID=%d terminato involontariamente per segnale %d\n",pid_terminated,(char)status);
}
