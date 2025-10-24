// soluzione esercizio system call turno 1 compito A - 22 giugno 2009

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/wait.h>


void attesa_terminazione_figlio();
void timeout();
void fineP1();
void fineP0();


int FD, p0p1[2], p1p2[2];


int main(int argc, char *argv[]){
	
	char c1, c2, file[80], carattere;
	int ByteLetti, N,pid1, pid2, test;
	
	/* controllo argomenti: */
	
	if (argc != 5)
	{
		printf("Utilizzo: %s f c1   c2   N \n",argv[0]);
		exit(-1);
	}
	
	if(argv[1][0]!='/')
	{
		printf("Il file deve avere nome assoluto\n");
		exit(-2);
	}

	if(argv[4][0]<'0' || argv[4][0]>'9' )
	{
		printf("N deve essere un numero\n");
		exit(-3);
	}
	if(N<0)
	{
		printf("N deve essere positivo\n");
		exit(-4);
	}

	if(strlen(argv[2])!=1)
	{
		printf("c0 deve essere un carattere\n");
		exit(-5);
	}

	if(strlen(argv[3])!=1)
	{
		printf("c1 deve essere un carattere\n");
		exit(-6);
	}
	if((FD=open(argv[1],O_RDONLY))<0)
	{
	perror("Errore nell'apertura del file:");
	exit(-7);
	}

	
	strcpy(file,argv[1]);
	c1 = argv[2][0];
	c2 = argv[3][0];
	N = atoi(argv[4]);


    /* Apertura pipe: */
	
	if(pipe(p0p1)<0)
   	{
       		perror("Errore apertura pipe p0p1");
	        exit(-6);
    	}
	
	if(pipe(p1p2)<0)
   	{
       		perror("Errore apertura pipe p1p2");
	        exit(-6);
    	}
    
	pid1=fork(); //Creazione Processo P1
	if(pid1<0) 
	{	    perror("Errore nella prima fork  (P1)");
		    exit(-1);
	}
    else if (pid1 == 0) //Codice figlio P1
	{	close(p1p2[0]);
		close(p0p1[1]);
		while (ByteLetti=read(p0p1[0], &carattere, 1)>0)
			if(carattere != c1)
    		{		test=write(p1p2[1], &carattere, 1);
					if(test<0)
						fineP1();
			}
		
		close(p0p1[0]);
		close(p1p2[1]);
		printf("P1 ha finito !\n");
		exit(0);
	}
	else //Codice Padre P0
	{   pid2=fork(); //Creazione Processo P2
		if(pid2<0) 
	    {      perror("Errore nella seconda fork(P2) ");
		       exit(-1);
        }
		else if (pid2 == 0) //Codice figlio P2
		{		signal(SIGALRM,timeout);
				alarm(N);
				close(p0p1[0]);
				close(p0p1[1]);
				close(p1p2[1]);
				while(	ByteLetti=read(p1p2[0], &carattere, 1)>0)
					if (carattere != c2)
						write(1, &carattere, 1);
				
				close(p1p2[0]);
				printf("P2 ha finito ! \n");
				exit(0);
        }
		else //Codice padre
        {	close(p0p1[0]);
			close(p1p2[0]);
			close(p1p2[1]);
			FD=open(file, O_RDONLY);
			while (ByteLetti=read(FD, &carattere, 1)>0)
			{	test=write(p0p1[1], &carattere, 1);
				if(test<0)
					fineP0();
			}
    		close(p0p1[1]);
			close(FD);
			attesa_terminazione_figlio();
			attesa_terminazione_figlio();
			exit(0);
        }
		
    }
}





        
void attesa_terminazione_figlio()
{   int pid_terminated,status;
	pid_terminated=wait(&status);
	if(WIFEXITED(status))
		printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
	else if(WIFSIGNALED(status))
		printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}


void timeout()
{	close(p1p2[0]);
	printf("P2 ha finito dil tempo");
	exit(-1);
}


void fineP1()
{	close(p0p1[0]);
	close(p1p2[1]);
	printf("P1 ha terminato");
	exit(-1);
}

void fineP0()
{	close(p0p1[1]);
	close(FD);
	attesa_terminazione_figlio();
  	attesa_terminazione_figlio();
  	exit(0);

}





