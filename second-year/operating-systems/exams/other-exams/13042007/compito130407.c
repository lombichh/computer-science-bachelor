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

/*Nota:
 *la soluzione proposta utilizza due segnali SIGUSR1 e SIGUSR2
 *per gestire la terminazione delle operazioni.
 *SIGUSR1 viene inviato nel caso il quadrante esaminato sia composto
 *da tutti valori nulli; SIGUSR2 nel caso opposto.
 *Ai processi viene implicitamente assegnata una priorita': P0, cioe'
 *il padre, sara' il primo a segnalare l'esito delle operazioni eseguite
 *(attraverso singole segnalazioni a P1, P2 e P3);
 *alla ricezione del segnale di P0, P1 potra' sengalare a propria volta
 *e cosi' via.
 *Per quanto riguarda la matrice, si suppone che essa sia memorizzata per righe,
 *e come sequenza di numeri int.
 */
 


void wait_child();
void handler_term(int signo);
void handler_cont(int signo);
void termina();
int check_null(int xmin, int xmax, int ymin,int ymax);
int get_max(int xmin, int xmax, int ymin,int ymax);
void replace(int xmin, int xmax, int ymin,int ymax,int value);


int file;
int pid1,pid2,pid3,ppid;
//num_rep indica il numero di segnalazioni ricevute
int num_rep;
//comunicazione_eseguita vale 1 se il processo ha gia' segnalato il proprio risultato
int  comunicazione_eseguita;
//res_null vale 1 se il quadrante esaminato e' composto di soli valori nulli
int res_null;
//num contiene il valore del parametro Num ricevuto in input
int num;


main(int argc, char* argv[])
{ 
	int pid;
	int fd1[2],fd2[2],fd3[2];

	int i=0;
		
	//1) Controllo parametri
	if(argc!=3) {
		printf("usage: %s <nome_file> <num>\n",argv[0]);
		exit(-1);
	}
	
	for(i=0;i<strlen(argv[2]);i++){
		if(argv[2][i]<'0' || argv[2][i]>'9'){
			printf("Il secondo argomento deve essere un numero\n");
		exit(-2);
		}
	}		
	num=atoi(argv[2]);
	
	//Apertura pipe da parte del padre
	if (pipe(fd1)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-3);
		} //P0 --> P1
	if (pipe(fd2)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-3);
		} //P0 --> P2

	ppid=getpid();
	
	//Binding dei segnali ai propri gestori
	signal(SIGUSR1,handler_term);
	signal(SIGUSR2,handler_cont);
						

	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-4);
	}
	
	if(pid1==0) {	
		//Codice P1
		int max=0;
		pid1=getpid();	
		
		//Chiusura di file e pipe non utilizzati e gestione segnali
		close(fd1[1]);
		close(fd2[0]);
		close(fd2[1]);
		
		//2b)Apertura dei file (IO-pointer da non condividere)
		if((file=open(argv[1],O_RDWR))<0) {
				perror("Error opening file:");
				exit(-5);
			}	
		
		
		//Lettura dei pid dei fratelli
		if(read(fd1[0],&pid2,sizeof(int))<0) {
				perror("Error lettura:");
				exit(-6);
				}
		if(read(fd1[0],&pid3,sizeof(int))<0) {
				perror("Error lettura:");
				exit(-6);
				}				
		close(fd1[0]);
		
		//Operazioni di P1 
		/*
		 *Si noti che il processo puo' venire interrotto
		 *durante l'esecuzione di queste operazioni: 
		 *in tal caso, la matrice di uscita puo' essere lasciata in uno
		 *stato inconsistente. Una soluzione a questo problema
		 *consiste nella disabilitazione dei segnali SIGUSR1 e SIGUSR2
		 *durante le operazioni.
		 */
		if(check_null(0,num/2,num/2,num)){
				res_null=1;
				}
		else	{
				 max=get_max(0,num/2,num/2,num);
				 replace(0,num/2, num/2,num,max);
				}	
				
		//DEBUGGING MESSAGE write(1,"P1 ha eseguito le operazioni\n",29);			
		
		do{		
			if(num_rep==4) termina();
			if(num_rep==1 && comunicazione_eseguita==0){
				//write(1,"Entra il primo figlio\n",23);    DEBUG
				
				/*
				 *La sleep seguente serve per (cercare di) evitare che la mancanza
				 *di affibilita' nella gestione dei segnali del sistema
				 *operativo pregiudichi il recapito dei segnali stessi.
				 */
				sleep(2);
				
				if(res_null==0){
					//Il quadrante esaminato non presenta valori tutti nulli
					kill(getppid(),SIGUSR2);
					kill(pid2,SIGUSR2);	
					kill(pid3,SIGUSR2);	
					}
				else {
					//Il quadrante esaminato presenta valori tutti nulli
					kill(getppid(),SIGUSR1);
					kill(pid2,SIGUSR1);	
					kill(pid3,SIGUSR1);	
					termina();
					}
				comunicazione_eseguita=1;
				num_rep++;
				}	
			 else pause();		
		   } while(1);		
	}
	
	else	{
			//Codice del padre
			if((pid2=fork())<0){
				perror("Errore nella seconda fork:");
				exit(-4);
			}
			if(pid2==0){
				//Codice P2
				int max=0;
				pid2=getpid();
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(fd1[0]);
				close(fd1[1]);
				close(fd2[1]);

				//2b)Apertura dei file (IO-pointer da non condividere)
				if((file=open(argv[1],O_RDWR))<0) {
						perror("Error opening file:");
						exit(-5);
					}	
				
				
				if(read(fd2[0],&pid3,sizeof(int))<0) {
						perror("Error lettura:");
						exit(-6);
						}		
				close(fd2[0]);				
				
				if(check_null(num/2,num,0,num/2)){
						res_null=1;
						}
				else	{
						 max=get_max(num/2,num,0,num/2);
						 replace(num/2,num,0,num/2,max);
						}	
				//DEBUGGING MESSAGE write(1,"P2 ha eseguito le operazioni\n",29);		
				do{		
					if(num_rep==4) termina();
					if(num_rep==2 && comunicazione_eseguita==0){
						sleep(2);
						if(res_null==0){
							kill(getppid(),SIGUSR2);
							kill(pid1,SIGUSR2);	
							kill(pid3,SIGUSR2);
							}
						else {
							kill(getppid(),SIGUSR1);
							kill(pid1,SIGUSR1);	
							kill(pid3,SIGUSR1);	
							termina();
							}	
						comunicazione_eseguita=1;	
						num_rep++;
						}	
					 else pause();		
				   } while(1);	
			  }//END If pid2
		else	{//Rispetto a pid2
					//Codice del padre
					if((pid3=fork())<0){
						perror("Errore nella seconda fork:");
						exit(-4);
					}
					if(pid3==0){
						//Codice P3
						int max=0;
						pid3=getpid();
						//Chiusura di file e pipe non utilizzati e gestione segnali
						close(fd1[0]);
						close(fd1[1]);
						close(fd2[0]);
						close(fd2[1]);
						
						//2b)Apertura dei file (IO-pointer da non condividere)
						if((file=open(argv[1],O_RDWR))<0) {
								perror("Error opening file:");
								exit(-5);
							}	
												
						if(check_null(num/2,num,num/2,num)){
								res_null=1;
								}
						else	{
								 max=get_max(num/2,num,num/2,num);
								 replace(num/2,num,num/2,num,max);
								}	
						//DEBUGGING MESSAGE write(1,"P3 ha eseguito le operazioni\n",29);									
						do{		
							if(num_rep==4) termina();
							if(num_rep==3 && comunicazione_eseguita==0){
								sleep(2);
								if(res_null==0){
									kill(getppid(),SIGUSR2);
									kill(pid1,SIGUSR2);	
									kill(pid2,SIGUSR2);	
									}
								else {
									kill(getppid(),SIGUSR1);
									kill(pid1,SIGUSR1);	
									kill(pid2,SIGUSR1);	
									termina();
									}
								comunicazione_eseguita=1;	
								num_rep++;
								}	
							 else pause();		
						   } while(1);	
					  }//END If pid3
				else {
						//Codice padre
						int max=0;
						//Chiusura di file e pipe non utilizzati e gestione segnali
						close(fd1[0]);
						close(fd2[0]);
						
						
						
						//2b)Apertura dei file (IO-pointer da non condividere)
						if((file=open(argv[1],O_RDWR))<0) {
								perror("Error opening file:");
								exit(-5);
							}	
						
						
						//Scrittura pid dei figli sulle pipe
						write(fd1[1],&pid2,sizeof(int));
						write(fd1[1],&pid3,sizeof(int));
						write(fd2[1],&pid3,sizeof(int));
						
						close(fd1[1]);
						close(fd2[1]);
						
						if(check_null(0,num/2,0,num/2)){
								res_null=1;
								}
						else	{
								 max=get_max(0,num/2,0,num/2);
								 replace(0,num/2,0,num/2,max);
								}	
						//DEBUGGIN MESSAGE write(1,"P0 ha eseguito le operazioni\n",29);										
						do{		
							if(num_rep==4) termina();
							if(comunicazione_eseguita==0){
								if(res_null==0){
									kill(pid1,SIGUSR2);
									kill(pid2,SIGUSR2);	
									kill(pid3,SIGUSR2);	
									}
								else {
									kill(pid1,SIGUSR1);
									kill(pid2,SIGUSR1);	
									kill(pid3,SIGUSR1);
									termina();	
									}
								comunicazione_eseguita=1;
								num_rep++;	
								}	
							 else pause();		
						   } while(1);	
				}//END else pid3 -->codice padre	  
			}//END else pid2	  
		}//END else pid1	  
}//END function			
		
/*
 *Check_null verifica che un settore della matrice
 *sia costituito da soli valori nulli
 */				
int check_null(int xmin, int xmax, int ymin,int ymax){
	int i=0,j=0,cur;
	for(j=0;j<xmax-xmin;j++){
		lseek(file,(num*(j+xmin)+ymin)*sizeof(int),SEEK_SET);
		for(i=0;i<ymax-ymin;i++){
			if(read(file,&cur,sizeof(int))<0){
				perror("Error lettura:");
				exit(-6);
				}
			if(cur!=0)return 0;
		}
	}
	fflush(0);
	return 1;
}

/*
 *Get_max determina il valore massimo contenuto in
 *un settore della matrice
 */	
int get_max(int xmin, int xmax, int ymin,int ymax){
	int max=0;
	int i=0,j=0,cur;
	for(j=0;j<xmax-xmin;j++){
		lseek(file,(num*(j+xmin)+ymin)*sizeof(int),SEEK_SET);
		for(i=0;i<ymax-ymin;i++){
			if(read(file,&cur,sizeof(int))<0){
				perror("Error lettura:");
				exit(-6);
				}
			if(cur>max)max=cur;
		}
	}
	return max;
}

/*
 *Replace sostituisce tutti gli elementi di
 *un settore della matrice con il valore val
 */
void replace(int xmin, int xmax, int ymin,int ymax,int val){
	int i=0,j=0;
	for(j=0;j<xmax-xmin;j++){
		lseek(file,(num*(xmin+j)+ymin)*sizeof(int),SEEK_SET);
		for(i=0;i<ymax-ymin;i++){
			write(file,&val,sizeof(int));
		}	
	}
}

void handler_term(int signo){
	num_rep++;
	char str[81];
	const char str2[81]=" quadrante tutto nullo!\n";
	
	//Composizione della stringa di stampa
	if(num_rep==1){strcpy(str,"Primo");}
	else if(num_rep==2){strcpy(str,"Secondo");}
	else if(num_rep==3){strcpy(str,"Terzo");}
	else if(num_rep==4){strcpy(str,"Quarto");}
	strcat(str,str2);
	
	write(1,str,strlen(str));
	termina();
	}

void handler_cont(int signo){
	num_rep++;
	}	

void termina(){
	close(file);
	if(ppid!=getppid()){//Sono il padre
		wait_child();
		wait_child();
		wait_child();
		}
	exit(0);	
	}

void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status)){
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
			fflush(0);}	
		else if(WIFSIGNALED(status)){
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
			fflush(0);}	
}
