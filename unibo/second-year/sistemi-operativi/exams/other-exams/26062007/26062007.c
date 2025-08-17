#include <stdio.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>
//#include "signame.c"
#define MAX 100000000;
#define MIN 0;
#define DIM 10;
	

//Nota Bene: le sleep introdotte sono utili per verificare il comportamento
//del programma a fronte di pressione della combinazione di tasti CTRL+C

void wait_child();
void handler_resignChild(int signo);
void handler_resignGChild(int signo);
void handler_termFather(int signo);
void handler_termChild(int signo);
void handler_termGChild(int signo);
void handler_nonresignChild(int signo);
void handler_nonresignGChild(int signo);
void handler_block(int signo);
int calc_occ(int fd,char* word, int len);


int fileout;
int blocked=0;
int pid0, pid1, pid2;
int p1p0[2],p2p0[2];

main(int argc, char* argv[])
{ 
	int filein;	
	int occurrences,numread;
	char outbuf[100];
		
	//1) Controllo parametri
	if(argc!=3) {
		printf("usage: %s <file1> <file2>\n",argv[0]);
		exit(-1);
	}
	if (argv[1][0]!='/'){
		printf("Il primo argomento devono essere un nome assoluto\n");
		exit(-1);
	}
	if (argv[2][0]!='/'){
		printf("Il secondo argomento devono essere un nome assoluto\n");
		exit(-1); 
	}
	

	if((fileout=open(argv[2],O_WRONLY))<0) {
		perror("Error opening file:");
		exit(-1);
	}

	//Apertura pipe da parte del padre
	if (pipe(p1p0)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-1);
		} //P1 --> P0
	if (pipe(p2p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-1);
		} //P2 --> P0
	
		
	//Parent PID
	pid0=getpid();
	
	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {		
			pid1=getpid();
			//Generazione del processo P2 (nipote di P0)
			if((pid2=fork())<0){
				perror("Errore nella seconda fork:");
				exit(4);
			}
			if(pid2==0){
				char* word="mobile";
				//Codice di P2
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(p1p0[0]);
				close(p1p0[1]);
				close(p2p0[0]);	
				signal(SIGUSR1,handler_resignGChild);
				signal(SIGQUIT,handler_termGChild);
				signal(SIGINT, handler_block);
				signal(SIGUSR2,handler_nonresignGChild);
				
				pid2=getpid();
			
				//Apertura del file da leggere
				if((filein=open(argv[1],O_RDONLY))<0) {
					perror("Error opening file:");
					exit(-4);
				}		
				
				write(p2p0[1],&pid2,sizeof(int));
				
				occurrences=calc_occ(filein,word,strlen("mobile"));
				close(filein);

				sprintf(outbuf,"Sono il nipote e la mia valutazione e': \n %d\n", occurrences);
				if(blocked==0) {
								write(fileout,outbuf,strlen(outbuf));
								write(p2p0[1],&occurrences,sizeof(int));
								close(p2p0[1]);
								//sleep(10);				
								}
				
				while(1)pause();
			}
		
			else {
			
				char* word="wireless";
				//Codice di P1
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(p1p0[0]);
				close(p2p0[0]);	
				close(p2p0[1]);
				signal(SIGUSR1,handler_resignChild);
				signal(SIGQUIT,handler_termChild);
				signal(SIGINT,handler_block);
				signal(SIGUSR2,handler_nonresignChild);
				
				//Apertura del file da leggere
				if((filein=open(argv[1],O_RDONLY))<0) {
					perror("Error opening file:");
					exit(-4);
				}		
				
				occurrences=calc_occ(filein,word,strlen("wireless"));
				close(filein);
				
				sprintf(outbuf,"Sono il figlio e la mia valutazione e': \n %d\n", occurrences);
				if(blocked==0){
							   write(fileout,outbuf,strlen(outbuf));
							   write(p1p0[1],&occurrences,sizeof(int));
							   close(p1p0[1]);		
							   //sleep(10);
							  }	
				
				while(1)pause();
				
			}
		}
	
	else	{
	int x1,x2;
	//Codice di P0
	//Chiusura di file e pipe non utilizzati e gestione segnali
	close(p1p0[1]);
	close(p2p0[1]);
	signal(SIGINT,handler_termFather);
	
	
	if((numread=read(p2p0[0],&pid2,sizeof(int)))!=sizeof(int)){
		perror("Errore lettura pipe");
		exit(-1);
		}			
	if((numread=read(p1p0[0],&x1,sizeof(int)))!=sizeof(int)){
		perror("Errore lettura pipe");
		exit(-1);
		}
	close(p1p0[0]);	
	if((numread=read(p2p0[0],&x2,sizeof(int)))!=sizeof(int)){
		perror("Errore lettura pipe");
		exit(-1);
		}		
	close(p2p0[0]);	
	//sleep(10);
	
	if(x1>x2) {kill(pid2,SIGUSR1);kill(pid1,SIGUSR2);}
	else if(x2>x1) {kill(pid1,SIGUSR1);kill(pid2,SIGUSR2);}
	else {kill(pid1,SIGUSR2);kill(pid2,SIGUSR2);}
	
	close(fileout);
	wait_child();
	exit(0);
	}
}

int calc_occ(int filein,char* word, int len){
	char buffer[20];
	char readcar[1];
	int numread=0, count=0, riga=0,i=0;
	
	if((numread=read(filein,buffer,len))==len){
		buffer[numread]='\0';
		for(i=0;i<len;i++){if(buffer[i]=='\n')riga++;} //Se il '/n' capita nei primi len caratteri... il successivo controllo da' esito negativo
		if(strcmp(buffer,word)==0){count++;printf("Increase %s %d\n",word,count);fflush(0);}
		printf("Letto %d %s\n",len,buffer);
	}
	while((numread=read(filein,readcar,1))>0){
		if(riga%2==0){
			//Shifto la string di confronto e le metto in coda il car letto
			for(i=0;i<len-1;i++){
				buffer[i]=buffer[i+1];
			}
			buffer[len-1]=readcar[0];
			//In buffer[len] c'e' gia' il terminatore
			if(strcmp(buffer,word)==0){count++;printf("Increase %s %d\n",word,count);fflush(0);}
			printf("Letto %s\n",buffer);
		}
		if(readcar[0]=='\n'){
			riga++;
			if(riga%2==0){
					if((numread=read(filein,buffer,len))==len){
						buffer[numread]='\0';
						for(i=0;i<len;i++){if(buffer[i]=='\n')riga++;} //Se il '/n' capita nei primi len caratteri... il successivo controllo da' esito negativo
						if(strcmp(buffer,word)==0){count++;printf("Increase %s %d\n",word,count);fflush(0);}
						printf("Letto %s\n",buffer);
					}
			}
		}
	}
	return count;
}

/*GESTORI DI SIGUSR1*/
void handler_resignChild(int signo){
	char outbuf[100];
	sprintf(outbuf,"Sono il figlio e accetto la decisione unanime\n");
	write(fileout,outbuf,strlen(outbuf)); 
	close(fileout);
	wait_child();
	exit(0);
}
void handler_resignGChild(int signo){
	char outbuf[100];
	sprintf(outbuf,"Sono il nipote e accetto la decisione unanime\n");
	write(fileout,outbuf,strlen(outbuf)); 
	close(fileout);
	exit(0);
}

/*GESTORI DI SIGUSR2*/
void handler_nonresignChild(int signo){
	close(fileout);
	wait_child();
	exit(0);
}
void handler_nonresignGChild(int signo){
	close(fileout);
	exit(0);
}

/*GESTORI DI SIGINT*/
void handler_termFather(int signo){
	lseek(fileout,0,SEEK_SET);
	write(fileout,"\nAccettazione unanime                  \n",strlen("\nAccettazione unanime                  \n"));
	kill(pid1,SIGQUIT);
	kill(pid2,SIGQUIT);
	close(fileout);
	wait_child();
	exit(0);
	}
//Serve per bloccare le operazioni nei figli	
void handler_block(int signo){
	blocked=1;
	}
	
/*GESTORI DI SIGQUIT*/		
void handler_termChild(int signo){
	write(fileout,"\nAccettazione unanime                  \n",strlen("\nAccettazione unanime                  \n"));
	close(fileout);
	close(p1p0[1]);
	wait_child();
	exit(0);
	}
void handler_termGChild(int signo){
	write(fileout,"\nAccettazione unanime                  \n",strlen("\nAccettazione unanime                  \n"));
	close(fileout);
	close(p2p0[1]);
	exit(0);
	}
	


void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}
