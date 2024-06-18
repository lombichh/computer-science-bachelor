/*
 *
 *  Created by Marco Montali on 18/06/06.
 * 
 */

#include <stdlib.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>
#define DIM 60


void wait_child();																//attesa di terminazione del proprio processo figlio

void print_message(int fd,char* id,int counter,int other_counter,int maiusc);	//stampa della frase da scrivere su fileOut

void P1P2_handler(int signo);													//handler utilizzato da P1 e P2 sia per capire se devono
																				//contare maiuscole o minuscole, che per sincronizzarsi
																				//sulla scrittura del risultato

int m,																			//flag che indica se contare le maiuscole o le minuscole
	use_flag=0;																	//flag per cambiare il comportamento dell'handler
char inf,sup;																	

main (int argc, char *argv[]){
	int i;
	int threshold;
	int pid_figlio,pid_nipote;
	int fd_fileIn,fd_fileOut,n,counter=0,other_counter;
	int pipeP1P2[2],pipeP2P1[2];
	char car,cur;
	// controllo parametri
	if (argc!=5) { 
		printf("Invocazione: %s fileIn fileOut car threshold\n",argv[0]);
		exit(-1);
	}
	if (argv[1][0]!='/'){
		printf("Il primo argomento devono essere un nome assoluto\n");
		exit(-2);
	}
	if (argv[2][0]!='/'){
		printf("Il secondo argomento devono essere un nome assoluto\n");
		exit(-3); 
	}
	car=argv[3][0];
	threshold=atoi(argv[4]);
	if(threshold<=0) {
		printf("Il quarto argomento deve essere un numero naturale\n");
		exit(-4);
	}
	if ((fd_fileIn=open(argv[1],O_RDONLY))<0){ 
		printf("Errore nell'apertura del file in ingresso %s\n", argv[1]);
		exit(-5); }
	n=lseek(fd_fileIn,SEEK_SET,SEEK_END); 	
	close(fd_fileIn);
	
	if ((fd_fileOut=open(argv[2],O_WRONLY|O_CREAT,0777))<0){ 
		printf("Errore nella creazione del file di uscita %s\n", argv[2]);
		exit(-5); }
	

	if((pid_figlio=fork())<0) {
		printf("Errore nella creazione di P1\n");
		exit(-6);
	}
	//codice di P0
	else if(pid_figlio>0) {
		fd_fileIn=open(argv[1],O_RDONLY);
		close(fd_fileOut);
		int reached=0;
		sleep(1);
		for(i=0;i<n/3;i++) {
			read(fd_fileIn,&cur,1);
			if(car==cur) counter++;
			if(counter==threshold) {
				kill(pid_figlio,SIGUSR1);
				reached=1;
				break;
			}
		}
		close(fd_fileIn);
		if(!reached) kill(pid_figlio,SIGUSR2);
		wait_child();
		exit(0);
	}
	//codice di P1
	else {
		if (pipe(pipeP1P2)<0){
			printf("Errore nella creazione prima pipe\n");
			exit(-7);
		}
		if (pipe(pipeP2P1)<0){
			printf("Errore nella creazione prima pipe\n");
			exit(-7);
		}
		signal(SIGUSR1,P1P2_handler);
		signal(SIGUSR2,P1P2_handler);
		if((pid_nipote=fork())<0) {
			printf("Errore nella creazione di P2\n");
			exit(-9);
		}
		//codice di P1
		else if(pid_nipote>0) {
			fd_fileIn=open(argv[1],O_RDONLY);
			close(pipeP1P2[0]);
			close(pipeP2P1[1]);
			pause();
			if(m)
				kill(pid_nipote,SIGUSR1);
			else
				kill(pid_nipote,SIGUSR2);
			lseek(fd_fileIn,n/3,SEEK_SET);
			counter=0;
			for(i=0;i<n/3;i++) {
				read(fd_fileIn,&cur,1);
				printf("letto %c stato %d\n",cur,counter);
				if(cur>=inf && cur<=sup) counter++;
			}
			close(fd_fileIn);	
			write(pipeP1P2[1],&counter,sizeof(int));
			read(pipeP2P1[0],&other_counter,sizeof(int));
			close(pipeP1P2[1]);
			close(pipeP2P1[0]);
			if(counter>=other_counter) {
				sleep(1);
				print_message(fd_fileOut,"P1",counter,other_counter,m);
				kill(pid_nipote,SIGUSR1);
			}
			else {
				pause();
				print_message(fd_fileOut,"P1",counter,other_counter,m);
			}
			close(fd_fileOut);
			wait_child();
			exit(0);
		}
		//codice di P2
		else {
			fd_fileIn=open(argv[1],O_RDONLY);
			close(pipeP1P2[1]);
			close(pipeP2P1[0]);
			pause();
			lseek(fd_fileIn,2*n/3,SEEK_SET);
			counter=0;
			for(i=0;i<n/3;i++) {
				read(fd_fileIn,&cur,1);
				if(cur>=inf && cur<=sup) counter++;
			}
			close(fd_fileIn);
			write(pipeP2P1[1],&counter,sizeof(int));
			read(pipeP1P2[0],&other_counter,sizeof(int));
			printf("P2: scritto %d, letto %d\n",counter,other_counter);
			close(pipeP1P2[1]);
			close(pipeP2P1[0]);
			if(counter>other_counter) {
				sleep(1);
				print_message(fd_fileOut,"P2",counter,other_counter,m);
				kill(getppid(),SIGUSR1);
			}
			else {
				pause();
				print_message(fd_fileOut,"P2",counter,other_counter,m);
			}
			close(fd_fileOut);
			exit(0);
		}
	}
}
	
	
	
void print_message(int fd,char* id,int counter,int other_counter,int maiusc) {
	char buf[DIM];
	sprintf(buf,"Sono %s ho trovato %s caratteri %s nella mia porzione di file\n",id,counter>other_counter?"piu":counter==other_counter?"uguali":"meno",m?"maiuscoli":"minuscoli");
	write(fd,buf,strlen(buf));
}
	
void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
	if(WIFEXITED(status))
		printf("%d) terminazione volontaria del figlio %d con stato %d\n",getpid(),pid_terminated,WEXITSTATUS(status));
	else if(WIFSIGNALED(status))
		printf("%d) terminazione involontaria del figlio %d a causa del segnale %d\n",getpid(),pid_terminated,WTERMSIG(status));
}

//handler utilizzato da P1 e P2
//invocato la prima volta, registra se vanno contate le maiuscole o le minuscole
//invocato la seconda volta, non fa nulla (serve solo per sbloccare il processo)
void P1P2_handler(int signo) {
	if(use_flag==0) {
		use_flag=1;
		if(signo==SIGUSR1) { 
			m=1;
			inf='A';
			sup='Z';
		}
		else if(signo==SIGUSR2) {
			m=0;
			inf='a';
			sup='z';
		}
	}
}	







