#include <stdio.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>
//#include "signame.c"
#define MAXDIM 255

int check_vietati(int fd, char buffer[], int num);
void scrivi(int fd, char buffer[], int num);
int leggi_da_terminale(char buffer[]);
void handler_termp0(int signo);
void handler_termp1(int signo);
void ripulisci(int fout, int fvietate);
void wait_child();

int fvietate,fout;
int p0p2[2],p2p0[2],p1p2[2],p2p1[2];
char fout_name[100];


main(int argc, char* argv[])
{ 

	int p0pid,p1pid;
	int pid1,pid2;
	int i=0;
			
	//1) Controllo parametri
	if(argc!=3) {
		printf("usage: %s <vietate> <fileOut>\n",argv[0]);
		exit(-1);
	}
	if (argv[1][0]!='/'){
		printf("Il primo argomento devono essere un nome assoluto\n");
		exit(-2);
	}
	for(i=0;i<strlen(argv[2]);i++)fout_name[i]=argv[2][i];
	
	
	//Apertura pipe 
	if (pipe(p0p2)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-4);
		} //P0 --> P2
	if (pipe(p2p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-4);
		} //P2 --> P0
	if (pipe(p1p2)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-4);
		} //P1 --> P2
	if (pipe(p2p1)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-4);
		} //P2 --> P1
		
	p0pid=getpid();	
		
	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {
	
			//INIZIO CODICE DI P1
			p1pid=getpid();
			//Generazione del processo P2 (nipote di P0)
			if((pid2=fork())<0){
				perror("Errore nella seconda fork:");
				exit(4);
			}
			if(pid2==0){
				//CODICE DI P2
				
				char buffer[MAXDIM];
				int len=MAXDIM,num,is_vietato,num_vietate=0;
				char vietato[]="VIETATO";
				
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(p0p2[1]);
				close(p2p0[0]);
				close(p1p2[1]);
				close(p2p1[0]);
				
				//Apertura file di output
				//2b)Apertura dei file (IO-pointer da condividere)
				//Apertura del file parole vietate
				if((fvietate=open(argv[1],O_RDONLY))<0) {
					perror("Error opening file:");
					exit(-3);
				}	
				
				//2b)Apertura dei file (IO-pointer da condividere)
				//Apertura del file parole vietate
				if((fout=open(argv[2],O_RDWR | O_CREAT))<0) {
					perror("Error opening file:");
					exit(-3);
				}	
				
				while(1) {
					
					//Lettura da P0
					if((num=read(p0p2[0],buffer,len))<0){
					perror("Error reading pipe:");
					exit(-5);
					}
					//printf("P2 riceve da P0 %s\n",buffer);					
					scrivi(fout,buffer,num);
					//Trasferimento a P1
					write(p2p1[1],buffer,num);					
					
					//Lettura da P1
					if((num=read(p1p2[0],buffer,len))<0){
					perror("Error reading pipe:");
					exit(-5);
					}
					//printf("P2 riceve da P1 %s\n",buffer);
					scrivi(fout,buffer,num);
					is_vietato=check_vietati(fvietate,buffer,num);			
					if(is_vietato) {
						printf("P2: STRINGA VIETATA DA P1: %s\n",buffer);
						num=8;
						write(p2p0[1],vietato,num);
						num_vietate++;
						if(num_vietate==3) {
							 ripulisci(fout,fvietate);
							 kill(p0pid,SIGUSR1);
							 kill(p1pid,SIGUSR1);
							 close(p0p2[0]);
							 close(p2p0[1]);
							 close(p1p2[0]);
							 close(p2p1[1]);
							 close(fvietate);
							 exit(0);
							}
						}
					//Trasferimento a P0
					else write(p2p0[1],buffer,num);					
					
					}
				
			}
		
			else {
				//CODICE DI P1
				
				char buffer[MAXDIM];
				char* stringa="Apertura comunicazione"; //len=23
				char* stringa_reply="ACK";
				int num;
				
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(p2p0[0]);
				close(p2p0[1]);
				close(p0p2[0]);
				close(p0p2[1]);
				close(p1p2[0]);
				close(p2p1[1]);
				signal(SIGUSR1,handler_termp1);
					
				//Apertura comunicazione
				//Lettura da P2
				if((num=read(p2p1[0],buffer,MAXDIM))<0){
				perror("Error reading pipe:");
				exit(-5);
				}
				printf("P1 riceve da P2 %s\n",buffer);
				if(strcmp(buffer,stringa)!=0){
				perror("Errore nell'apertura della comunicazione:");
				exit(-6);
				}
				write(p1p2[1],stringa_reply,strlen(stringa_reply)+1);
				
				while(1) {
				
					if((num=read(p2p1[0],buffer,MAXDIM))<0){
					perror("Error reading pipe:");
					exit(-5);
					}
					printf("P1 riceve da P0 %s\n",buffer);
					//Lettura del messaggio utente
					printf("P1: Digitare messaggio\n",buffer);
					num=leggi_da_terminale(buffer);
					write(p1p2[1],buffer,num);				
				
				}
										
			}//ELSE
		}//IF su pid2
	
	else	{
		
		//CODICE DI PADRE P0
				
		char buffer[MAXDIM];
		char* stringa="Apertura comunicazione"; //len=23
		char* stringa_reply="ACK";
		int num,is_vietato=0,i=0;
		
		//Chiusura di file e pipe non utilizzati e gestione segnali
		close(p2p1[0]);
		close(p2p1[1]);
		close(p1p2[0]);
		close(p1p2[1]);
		close(p0p2[0]);
		close(p2p0[1]);
		signal(SIGUSR1,handler_termp0);

		//Apertura file di output
		//2b)Apertura dei file (IO-pointer da condividere)
		//Apertura del file parole vietate
		if((fvietate=open(argv[1],O_RDONLY))<0) {
			perror("Error opening file:");
			exit(-3);
		}	
		
		//Apertura comunicazione
		write(p0p2[1],stringa,strlen(stringa)+1);
		
		//Lettura da P2
		if((num=read(p2p0[0],buffer,MAXDIM))<0){
		perror("Error reading pipe:");
		exit(-5);
		}
		printf("P0 riceve da P2 %s\n",buffer);
		if(strcmp(buffer,stringa_reply)!=0){
		perror("Errore nell'apertura della comunicazione:");
		exit(-6);
		}
		
		while(1) {
			do {
				printf("P0: Digitare messaggio\n",buffer);
				num=leggi_da_terminale(buffer);
				is_vietato=check_vietati(fvietate,buffer,num);
				} while(is_vietato);
			write(p0p2[1],buffer,num);
			if((num=read(p2p0[0],buffer,MAXDIM))<0){
			perror("Error reading pipe:");
			exit(-5);
			}
			printf("P0 riceve da P1 %s\n",buffer);
			
		}		
		
	}//ELSE
}


void scrivi(int fd, char buffer[], int num) {
	write(fd,buffer,num);
	//Semplice aggiunta di un a capo 
	write(fd,"\n",1);
	}


int check_vietati(int fd, char buffer[], int num) {
	char cur[1];
	char temp[MAXDIM];
	int i=0;
	
	//Per prima cosa si riporta l'I/O pointer all'inizio del file
	lseek(fd,0,SEEK_SET);
	
	//Quindi si procede con la lettura carattere per carattere
	while(read(fd,cur,1)==1){
		if(cur[0]=='\n'){ //Stranamente anche l'EOF rientra in questo caso
			//Aggiunta del terminatore necessaria per utilizzare strcmp
			temp[i]='\0';
			if(strcmp(temp,buffer)==0) return 1;
			else {i=0;}
			}
		else{	
			temp[i]=cur[0];	
			i++;
			}
		}
	return 0;
}
					
int leggi_da_terminale(char buffer[]) {
	char cur[1];
	int i=0;
	
	while(read(0,cur,1)==1){
		//In questo caso interpretiamo il new_line come il carattere di fine input
		if(cur[0]=='\n') {
				buffer[i]='\0';
				return i+1;
				}
		else{
			buffer[i]=cur[0];
			i++;
			}
	}
}

void handler_termp0(int signo) {
	close(p0p2[1]);
	close(p2p0[0]);
	close(fvietate);
	wait_child();
	exit(0);
	}
	
void handler_termp1(int signo) {
    close(p1p2[1]);
	close(p2p1[0]);
	wait_child();
	exit(0);
	}

void ripulisci (int fout, int fvietate) {
	char temp[MAXDIM],curr[1];
	int i=0,ftemp,fout2;
	
	//Apertura file temporaneo
	if((ftemp=open("tmp",O_RDWR|O_TRUNC))<0) {
			perror("Error opening file:");
			exit(-3);
		}	
	lseek(fout,0,SEEK_SET);	
	while(read(fout,curr,1)==1) {
		temp[i]=curr[0];
		if(temp[i]=='\n'){
			//Aggiunta del terminatore, in quanto check_vietati assume che il messaggio in input sia una 
			//stringa con terminatore
			temp[i]='\0';
			if(check_vietati(fvietate,temp,i-1)!=1){
					scrivi(ftemp, temp, i);
				}
			i=0;	
			}
		else i++;	
		}
	//Azzeramento di fout
	close(fout);
	if((fout2=open(fout_name,O_WRONLY|O_TRUNC))<0) {
			perror("Error opening file:");
			exit(-3);
		}
	//Copiatura da ftemp
	lseek(ftemp,0,SEEK_SET);	
	while(read(ftemp,curr,1)==1) {
		write(fout2,curr,1);
		}
	close(ftemp);
	close(fout2);
}

void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}
