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

void wait_child();
void handler_min(int signo);
void handler_term(int signo);
void write_min();
void write_max();
void read_min_max(int riga_target1,int riga_target2);

int file1,file2,file3;
int p0p1[2],p1p0[2],p1p2[2],p2p1[2],p2p0[2];
int pid0,pid1,pid2;
int filetemp;

int my_min=MAX;
int my_max=-MAX;
int p0_max,p0_min,p1_max,p1_min,p2_max,p2_min;
int temp_max=0,temp_min=100000000;

main(int argc, char* argv[])
{ 
	int pid;
	int i=0,num=0,num2=0,num_righe=0;
	char buffer1[1],buffer2[10];
	int riga_target1=0,riga_target2=0;

		
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
	//Apertura del file da leggere
	if((filetemp=open(argv[1],O_RDONLY))<0) {
		perror("Error opening file:");
		exit(-4);
	}	
	if((file2=open(argv[2],O_WRONLY|O_TRUNC))<0) {
		perror("Error opening file:");
		exit(-4);
	}

	//Apertura pipe da parte del padre
	if (pipe(p0p1)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-7);
		} //P0 --> P1
	if (pipe(p1p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-7);
		} //P1 --> P0
	if (pipe(p1p2)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-7);
		} //P1 --> P2
	if (pipe(p2p1)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-7);
		} //P2 --> P1
	if (pipe(p2p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-7);
		} //P2 --> P0
	
	//Conteggio del numero di righe
	while((num=read(filetemp,buffer1,1))) {
		if(buffer1[0]=='\n') {
			num_righe++; 
		}
	}
	close(filetemp);
	
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
				//Codice di P2
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(p0p1[0]);
				close(p0p1[1]);
				close(p1p0[0]);
				close(p1p0[1]);
				close(p1p2[1]);
				close(p2p1[0]);
				close(p2p0[0]);	
				signal(SIGUSR1,handler_min);
				signal(SIGUSR2,handler_term);
				
				pid2=getpid();
			
				//Invio del pid di P2 a P0
				/*Si faccia attenzione a questo utilizzo della system call write
				 *Poiche' e' dichiarata come  
				 *ssize_t write(int d, const void *buf, size_t nbytes)
				 *essa accetta come secondo parametro un puntatore ad un qualunque tipo di 
				 *dato, quindi anche un int* */ 				
				write(p2p0[1],&pid2,sizeof(int));
				close(p2p0[1]);
				
				//Apertura del file da leggere
				if((file1=open(argv[1],O_RDONLY))<0) {
					perror("Error opening file:");
					exit(-4);
				}		
				
				riga_target1=num_righe*2/3;
				riga_target2=num_righe;
				
				read_min_max(riga_target1,riga_target2);
				printf("P2 %d %d\n",my_min,my_max);
				
				//Invio dei risultati a p1
				write(p2p1[1],&my_max,sizeof(int));
				write(p2p1[1],&my_min,sizeof(int));		
				close(p2p1[1]);
								
				//Attesa dei risultati da p0 e p1 (inoltrati tutti da p1)
				if(read(p1p2[0],&p1_max,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}
				if(read(p1p2[0],&p1_min,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}
				if(read(p1p2[0],&p0_max,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}
				if(read(p1p2[0],&p0_min,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}	
				close(p1p2[0]);
				printf("%d %d %d %d\n",p0_max,p0_min,p1_max,p1_min);
				
				if(my_max>p1_max && my_max>p0_max) {
					write_max();
					if(my_min<p1_min && my_min<p0_min) {
						write_min();
						close(file2);
						exit(0);						
						}
					//else Segnalazione al processo che ha letto il valore minimo	
					else if(p0_min<=p1_min) 
						kill(pid0,SIGUSR1);
					else 
						kill(pid1,SIGUSR1);
					}	
				while(1)pause();
			}
		
			else {
			
				//Codice P1
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(p0p1[1]);
				close(p1p0[0]);
				close(p1p2[0]);
				close(p2p1[1]);
				signal(SIGUSR1,handler_min);
						
				//Apertura del file da leggere
				if((file1=open(argv[1],O_RDONLY))<0) {
					perror("Error opening file:");
					exit(-4);
				}		
				
				riga_target1=num_righe/3;
				riga_target2=num_righe*2/3;
				
				read_min_max(riga_target1,riga_target2);
				printf("P1 %d %d\n",my_min,my_max);
				
				//Invio dei risultati a p2
				write(p1p2[1],&my_max,sizeof(int));
				write(p1p2[1],&my_min,sizeof(int));
				//Invio dei risultati a p0
				write(p1p0[1],&my_max,sizeof(int));
				write(p1p0[1],&my_min,sizeof(int));
												
				//Attesa dei risultati da p0 e loro invio a p2
				if(read(p0p1[0],&p0_max,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}else write(p1p2[1],&p0_max,sizeof(int));
				if(read(p0p1[0],&p0_min,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}else write(p1p2[1],&p0_min,sizeof(int));
				close(p0p1[0]);
				close(p1p2[1]);
							
				//Attesa dei risultati da p2 e loro invio a p0
				if(read(p2p1[0],&p2_max,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}else write(p1p0[1],&p2_max,sizeof(int));
				if(read(p2p1[0],&p2_min,sizeof(int))<0){
					perror("Error reading pipe:");
					exit(-5);
				}else write(p1p0[1],&p2_min,sizeof(int));
				close(p2p1[0]);
				close(p1p0[1]);		
				
				
				if(my_max>=p2_max && my_max>p0_max) {
					write_max();
					if(my_min<=p2_min && my_min<p0_min) {
						write_min();
						kill(pid2,SIGUSR2);	
						close(file2);
						wait_child();
						exit(0);						
						}
					//else Segnalazione al processo che ha letto il valore minimo	
					else if(p0_min<=p2_min) 
						kill(pid0,SIGUSR1);
					else 
						kill(pid2,SIGUSR1);
					}	
				wait_child(); 
				close(file2);
				exit(0);
			}
		}
	
	else	{
	//Codice di P0
	//Chiusura di file e pipe non utilizzati e gestione segnali
	close(p0p1[0]);
	close(p1p0[1]);
	close(p1p2[0]);
	close(p1p2[1]);
	close(p2p1[0]);
	close(p2p1[1]);	
	close(p2p0[1]);
	signal(SIGUSR1,handler_min);
	
	//Lettura del pid di P2
	if(read(p2p0[0],&pid2,sizeof(int))<0){
		perror("Error reading pipe:");
		exit(-5);
	}
	close(p2p0[0]);
									
	//Apertura del file da leggere
	if((file1=open(argv[1],O_RDONLY))<0) {
		perror("Error opening file:");
		exit(-4);
	}		
	
	riga_target1=0;
	riga_target2=num_righe/3;
	
	read_min_max(riga_target1,riga_target2);
	printf("P0 %d %d\n",my_min,my_max);
		
	//Invio dei risultati a p1
	write(p0p1[1],&my_max,sizeof(int));
	write(p0p1[1],&my_min,sizeof(int));		
	close(p0p1[1]);
	//Attesa dei risultati da p0 e p1 (inoltrati tutti da p1)
	if(read(p1p0[0],&p1_max,sizeof(int))<0){
		perror("Error reading pipe:");
		exit(-5);
	}
	if(read(p1p0[0],&p1_min,sizeof(int))<0){
		perror("Error reading pipe:");
		exit(-5);
	}
	if(read(p1p0[0],&p2_max,sizeof(int))<0){
		perror("Error reading pipe:");
		exit(-5);
	}
	if(read(p1p0[0],&p2_min,sizeof(int))<0){
		perror("Error reading pipe:");
		exit(-5);
	}	
	close(p1p0[0]);
	
	if(my_max>=p1_max && my_max>=p2_max) {
		write_max();
		if(my_min<=p1_min && my_min<=p2_min) {
			write_min();
			kill(pid2,SIGUSR2);	
			close(file2);
			wait_child();
			exit(0);						
			}
		//else Segnalazione al processo che ha letto il valore minimo	
		else if(p1_min<=p2_min) 
			kill(pid1,SIGUSR1);
		else 
			kill(pid2,SIGUSR1);
		}	
	wait_child();
	close(file2);
	exit(0);
	}
}


void handler_min(int signo) {
	int my_pid=getpid();
	write_min();
	if(pid2!=my_pid)kill(pid2,SIGUSR2);
	else {
		close(file2);
		exit(0);
	}
}

void handler_term(int signo) {
	close(file2);
	exit(0);
}

void read_min_max(int riga_target1,int riga_target2) {
	int riga=0,num=0,cur_num=0,i=0;
	char buffer1[1],buffer2[10];
	lseek(file1,0,SEEK_SET);	
				
	while((num=read(file1,buffer1,1))) {
		if(buffer1[0]=='\n') {				
			if(riga_target1<=riga && riga_target2>riga){
					buffer2[i]='\0';
					cur_num=atoi(buffer2);
					if(cur_num>my_max) my_max=cur_num;
					if(cur_num<my_min) my_min=cur_num;
				}
			riga++; 
			i=0;				
		}
		if(riga_target1<=riga && riga_target2>riga) {
			buffer2[i]=buffer1[0];
			i++;
		}			
	}
				
}
	
void write_min() {
	char buf[10];
	printf("%d\n",my_min);
	strtol(buf,NULL,10);
	sprintf(buf,"%d\n",my_min);
	write(file2,buf,strlen(buf));
}

void write_max() {
	char buf[10];
	printf("%d\n",my_max);
	strtol(buf,NULL,10);
	sprintf(buf,"%d\n",my_max);
	write(file2,buf,strlen(buf));
}	

void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}
