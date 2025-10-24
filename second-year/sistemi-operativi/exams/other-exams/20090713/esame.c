#include <stdio.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>

void wait_child();
int pid0, pid1, pid2;
int p0p1[2],p0p2[2];

int main(int argc,char ** argv)
{


	if(argc!=4)
	{	
		printf("Sintassi del comando errata: %s <nome file> <comando> <comando>\r\n",argv[0]);
		exit(-1);
	}

	pid0=getpid();

	//--- apertura pipe da parte del padre-------------
	if (pipe(p0p1)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-1);
	} //P0 --> P1
	if (pipe(p0p2)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-1);
	} //P0 --> P2

	pid1=fork();
	if(pid1 == 0){//figlio p1
		close(p0p1[1]);
		close(p0p2[1]);
		close(p0p2[0]);

		//Ridirezione di standard input sulla pipe
		close(0);
		dup(p0p1[0]);
		close(p0p1[0]);

		execlp(argv[2],argv[2],(char *)0);
	}
	else{
		pid2=fork();
		if(pid2 == 0){//figlio p2
			close(p0p1[1]);
			close(p0p2[1]);
			close(p0p1[0]);

			//Ridirezione di standard input sulla pipe
			close(0);
			dup(p0p2[0]);
			close(p0p2[0]);

			execlp(argv[3],argv[3],(char *)0);

		}
		else{//padre
			close(p0p1[0]);
			close(p0p2[0]);
			int fileIn=open(argv[1],O_RDONLY);
			char buffer;

			sleep (2);
			int byteLetti;
			while((byteLetti=read(fileIn,&buffer,sizeof(char)))>0){//leggo 1 carattere per volta
				if(buffer%2!=0)
					write(p0p1[1],&buffer,1);
				else
					write(p0p2[1],&buffer,1);
				
			}
			close(p0p1[1]);
			close(p0p2[1]);
			wait_child();
			wait_child();

		}
	}
}

void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}
	

