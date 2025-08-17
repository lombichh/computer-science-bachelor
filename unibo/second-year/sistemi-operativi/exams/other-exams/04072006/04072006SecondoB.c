#include <stdio.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>
//#include "signame.c"

void wait_child();
void handler_p1(int signo);
void handler_p2(int signo);

int file2,file3;
int fd1[2],fd2[2];
int pid2;

main(int argc, char* argv[])
{ 
	int file1;
	int fd3[2];
	int pid,pid1;
	int i=0,num=0,num2=0,riga=0;
	char buffer1[1],buffer2[1];
		
	//1) Controllo parametri
	if(argc!=3) {
		printf("usage: %s <file1> <file2>\n",argv[0]);
		exit(2);
	}
	if (argv[1][0]!='/'){
		printf("Il primo argomento devono essere un nome assoluto\n");
		exit(-2);
	}
	if (argv[2][0]!='/'){
		printf("Il secondo argomento devono essere un nome assoluto\n");
		exit(-3); 
	}
	
	//2b)Apertura dei file (IO-pointer da condividere)
	if((file1=open(argv[1],O_RDONLY))<0) {
		perror("Error opening file:");
		exit(-4);
	}
	if((file2=open(argv[2],O_RDWR))<0) {
		perror("Error opening file:");
		exit(-4);
	}

	
	//Apertura pipe da parte del padre
	if (pipe(fd1)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-7);
		} //P0 --> P1
	if (pipe(fd2)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-7);
		} //P1 --> P2
	if (pipe(fd3)<0){
			printf("Errore nella creazione della terza pipe\n");
			exit(-7);
		} //P2 --> P1
	
	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {		
		//Codice P1
		//Chiusura di file e pipe non utilizzati e gestione segnali
		close(fd1[1]);
		close(fd3[1]);
		close(fd2[0]);
		close(file1);		
		signal(SIGINT,handler_p1);	
			
		if((file3=open(argv[2],O_RDONLY))<0) {
			perror("Error opening file:");
			exit(-4);
		}		
		
		//Lettura del pid del secondo figlio P2
		read(fd3[0],&pid2,sizeof(int));	
		close(fd3[0]);
		//Lettura da file3, confronto con fd1 e scrittura su fd2
		while((num=read(file3,buffer1,1))) {
			if(buffer1[0]=='\n') {
				riga++; 
			}
			if(riga%3==0) {
				if((num2=read(fd1[0],buffer2,1))) {
					if(buffer1[0]!=buffer2[0]) {
						if (write(fd2[1],buffer1,1)!=1) {
							perror("Errore nella scrittura:");
							exit(-6);
							}
						if (write(fd2[1],buffer2,1)!=1) {
							perror("Errore nella scrittura:");
							exit(-6);
							}	
						//sleep(1);  -->utile per verificare il comportamento del programma nel caso 
						//venga premuto CTRL-C
					}
				}				
			}
		}
		
		exit(0);
	}
	
	else	{
	   //Codice del padre
			if((pid2=fork())<0){
				perror("Errore nella seconda fork:");
				exit(4);
			}
			if(pid2==0){
				//Codice di P2
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(fd1[0]);
				close(fd1[1]);
				close(fd2[1]);
				close(fd3[0]);
				close(file1);
				close(file3);
				signal(SIGUSR1,handler_p2);
				signal(SIGINT,handler_p2);
								
				//Comunicazione proprio pid a p1 												
				pid=getpid();				
				write(fd3[1],&pid,sizeof(int));
				close(fd3[1]);
				//Lettura da fd2 e scrittura su file2
				while((num=read(fd2[0],buffer1,1))) {
					write(file2,buffer1,1);
					//sleep(5);  -->utile per verificare il comportamento del programma nel caso 
					//venga premuto CTRL-C
				}	
				ftruncate(file2,lseek(file2,0,SEEK_CUR));
				
				//Chiusura file pipe
				close(fd2[0]);
				close(file2);
				exit(0);	
			}
			
			else {
				//Codice del padre
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(fd1[0]);
				close(fd2[1]);
				close(fd3[0]);
				close(fd3[1]);
				close(fd2[0]);
				close(file2);
				close(file3);
				
				//Lettura da file1 e scrittura su pipe fd1
				while((num=read(file1,buffer1,1))) {
					if(buffer1[0]=='\n') {
						riga++; 
					}
					if(riga%3==0) {
						if (write(fd1[1],buffer1,1)!=1) {
							perror("Errore nella scrittura:");
							exit(-6);
							}
					}		
				 }
	
				 //Chiusura pipe/file e attesa dei figli
				 close(fd1[1]);
				 close(file1);
				 wait_child();
				 wait_child();
				 exit(0);
			}
		    
	}
}

void handler_p1(int signo) {
	if(signo==SIGINT) {
			write(file2,"Premuto CTRL-C",14);
			kill(pid2,SIGUSR1);
			close(fd1[0]);
			close(fd2[1]);
			close(file3);
			close(file2);
			exit(1);
	}
}
	
void handler_p2(int signo) {
	if(signo==SIGUSR1) {
			write(file2,"Bloccato da P1",14);
			ftruncate(file2,lseek(file2,0,SEEK_CUR));
			close(fd2[0]);
			close(file2);
			exit(1);
	}
	//Se arriva il SIGINT il processo non deve fare nulla, ma attendere
	//SIGUSR1 da p2	
}

void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}
