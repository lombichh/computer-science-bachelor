#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <signal.h>
#include <signal.h>

//esame Fin parola M

int M;
int pipefd[2];

void alrm_handler1()
{
    printf("Sono P2. il mio PID è %d. Il numero di occorrenze è divisibile per %d\n", getpid(),  M);
    exit(EXIT_SUCCESS);
}

void alrm_handler2()
{
    printf("Sono P2. il mio PID è %d. Il numero di occorrenze NON è divisibile per %d\n", getpid(),  M);
    exit(EXIT_SUCCESS);
}

int main(int argc, char* argv[])
{
    int pid[2], fd, result;
    
    //il solito controllo molto blando
    if(argc != 4)
    {
        fprintf(stderr, "Numero di parametri non valido\n");
        exit(EXIT_FAILURE);
    }
    
    if (argv[1][0]!='/'){
		printf("Il primo argomento deve essere un nome assoluto di file\n");
		exit(-2);
	}
	
	M = atoi(argv[3]);
	if ( M <= 0  ){
        printf("Il terzo argomento deve essere un intero positivo\n");
        exit(-3);
    }
    
    if ((fd=open(argv[1], O_RDONLY))<0)
    {   perror("errore nell'apertura della classifica");
        exit(EXIT_FAILURE);
    }
    close(fd);
    
    if (pipe(pipefd)<0) exit(-4); //apertura pipe
    
        //creazione figli
        pid[0] = fork();
        if ( pid[0] == 0 ) 
        {   // figlio1
            close(pipefd[0]);
            close(1);
            dup(pipefd[1]);
            close(pipefd[1]);
            
            execlp("grep", "grep","-c", argv[2], argv[1], (char*) 0);
            perror("P1: Errore nella execlp\n");
            exit(EXIT_FAILURE);
        }
        pid[1] = fork();
        if ( pid[1] == 0 )
        {   // figlio2
            signal(SIGUSR1, alrm_handler1);
            signal(SIGUSR2, alrm_handler2);
            close(pipefd[1]);
            close(pipefd[0]);
            pause();
            exit(EXIT_SUCCESS);
        }
        if ( pid[1] > 0 ) 
        {   // Eseguito dal padre
            close(pipefd[1]);
            char num[4];
            int nread, i=0;
            while( (nread=read(pipefd[0], &num[i], sizeof(char)))>0){
                i++;
            }
            num[i]='\0';
            result=atoi(num);
            printf("****P0: result=%d\n", result);
            if((result%M) == 0)
            {
                kill(pid[1], SIGUSR1);
            }
            else
            {
                kill(pid[1], SIGUSR2);
            }
        }
        else {
            perror("Fork error:");
            exit(1);
        }
    return 0;
    
}















