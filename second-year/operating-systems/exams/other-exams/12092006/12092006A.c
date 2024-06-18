#include <stdio.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>

void handler_para(int signo);
void handler_tira(int signo);
void handler_term1(int signo);
void handler_term2(int signo);
void handler_int(int signo);
void wait_child();

int p1p0[2], p2p0[2], fileOut, pid1, pid2;
int rig_num, segnalato=0;

main(int argc, char* argv[])
{ 	//1) Controllo parametri
	if(argc!=2) {
		printf("usage: %s <fileOut>\n",argv[0]);
		exit(-1);
	}
	if (argv[1][0]!='/'){
		printf("Il primo argomento devono essere un nome assoluto\n");
		exit(-2);
	}
	//2b)Apertura dei file (IO-pointer da condividere)
	//Apertura del file da leggere
	if((fileOut=open(argv[1],O_WRONLY|O_CREAT))<0) {
		perror("Error opening file:");
		exit(-3);
	}	
	
	//Apertura pipe da parte del padre
	if (pipe(p1p0)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-4);
		} //P1 --> P0
	if (pipe(p2p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-4);
		} //P2 --> P0
	
	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {//Generazione del processo P2 (nipote di P0)
			if((pid2=fork())<0){
				perror("Errore nella seconda fork:");
				exit(4);
			}
			if(pid2==0){
				int my_pid=getpid();
				//Codice di P2
				close(p1p0[0]); close(p1p0[1]); close(p2p0[0]);	
				signal(SIGUSR1,handler_para);
				signal(SIGUSR2,handler_term2);
				signal(SIGINT,SIG_IGN);
				
				//Invio del pid al padre
				write(p2p0[1],&my_pid,sizeof(int));
				
				while(1)pause();
			}
		
			else {//Codice di P2
				close(p2p0[0]); close(p2p0[1]); close(p1p0[0]);	
				signal(SIGUSR1,handler_tira);
				signal(SIGUSR2,handler_term1);
				signal(SIGINT,SIG_IGN);
								
				while(1)pause();			
			}
		}
	
	else	{
	int i=0,tiro=0,parata=0;
	char out_str[3];
	//Codice di P0
	close(p1p0[1]); close(p2p0[1]);
	signal(SIGINT,handler_int);
	
	//Lettura del PID di P2
	if(read(p2p0[0],&pid2,sizeof(int))<0){
		perror("Error reading pipe:");
		exit(-6);
	}
	
	out_str[1]=' ';
	for(rig_num=0;rig_num<10 && !segnalato;rig_num++) {
		//Segnalazione ai figli
		kill(pid1,SIGUSR1);
		kill(pid2,SIGUSR1);
		
		//Attesa dei risultati da p0 e p1
		if(read(p1p0[0],&tiro,sizeof(int))<0){
			perror("Error reading pipe:");
			exit(-6);
		}
		if(read(p2p0[0],&parata,sizeof(int))<0){
			perror("Error reading pipe:");
			exit(-6);
		}		
		
		sprintf(out_str,"Rigore numero %d ",rig_num);
		write(fileOut,out_str,strlen(out_str));
		if(tiro==parata) write(fileOut,"parato\n",7);
		else write(fileOut,"segnato\n",8);
		
		}
	//Se ha ricevuto il segnale SIG_INT il padre deve 
	//scrivere su fileOut e attendere la terminazione dei figli
	if(segnalato) {
		char str_out[100];
		sprintf(str_out,"Partita interrotta dopo %d rigori\n",rig_num);
		write(fileOut,str_out,strlen(str_out));
		}		
	
	close(fileOut); close(p2p0[0]); close(p1p0[0]);	
	kill(pid1,SIGUSR2);
	kill(pid2,SIGUSR2);	
	wait_child();	
	exit(0);
	}
}


void handler_para(int signo) {
	long num;
	int res,i;
	num=rand();
	res=num%2;
	if(res==0) {
		write(fileOut,"Mi tuffo a sin\n",15);
		write(p2p0[1],&res,sizeof(int));
		}
	else {
		write(fileOut,"Mi tuffo a des\n",15);
		write(p2p0[1],&res,sizeof(int));
	    }
}

void handler_tira(int signo){
	long num;
	int res;
	num=rand();
	res=num%2;
	if(res==0) {
		write(fileOut,"Tiro a sin\n",11);
		write(p1p0[1],&res,sizeof(int));
		}
	else {
		write(fileOut,"Tiro a des\n",11);
		write(p1p0[1],&res,sizeof(int));
	    }
}

void handler_term1(int signo) {
	close(fileOut); close(p1p0[1]);
	wait_child();
	exit(0);
}

void handler_term2(int signo) {
	close(fileOut); close(p2p0[1]);
	exit(0);
}

void handler_int(int signo) {
	segnalato=1;
}	

void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}