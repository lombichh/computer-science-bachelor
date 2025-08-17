#include <stdio.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <unistd.h>
#define MAX 80

void handler_term_int(int signo);
void handler_termp1(int signo);
void handler_termp2(int signo);
void wait_child();

int p0p1[2], p1p2[2], p2p0[2];
int fileIn,fileScartati;
int tot_ricevuti,num1,num2;

main(int argc, char* argv[])
{ 
  int pid0,pid1,pid2;
   
	//1) Controllo parametri
	if(argc!=4) {
		printf("usage: %s <file> <Num1> <Num2>\n",argv[0]);
		exit(-1);
	}
	if (argv[1][0]!='/'){
		printf("Il primo argomento deve essere un nome assoluto\n");
		exit(-2);
	}
	if ('1'>argv[2][0] || argv[2][0]>'9'){
		printf("Il secondo argomento deve essere un valore numerico tra 1 e 9\n");
		exit(-2);
	}
	else num1=atoi(argv[2]);
	if ('1'>argv[3][0] || argv[3][0]>'9'){
		printf("Il terzo argomento deve essere un valore numerico tra 1 e 9\n");
		exit(-2);
	}
	else num2=atoi(argv[3]);
	
	//2b)Apertura dei file (IO-pointer da condividere)
	//Apertura del file da leggere
	if((fileIn=open(argv[1],O_RDONLY))<0) {
		perror("Error opening file in:");
		exit(-3);
	}	
	if((fileScartati=open("scartati.txt",O_RDWR | O_CREAT | O_TRUNC,S_IRWXU))<0) {
		perror("Error opening file out:");
		exit(-3);
	}	
	
	//Apertura pipe da parte del padre
	if (pipe(p0p1)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-4);
		} //P0 --> P1
	if (pipe(p1p2)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-4);
		} //P1 --> P2
	if (pipe(p2p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-4);
		} //P2 --> P0
	
				
	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {	
				int num=0,i=0,j=0,index=1;
				char buffer[MAX];
				char outbuffer[MAX];
				char scartato[1];
				
				//Codice di P1
				//Chiusura di file e pipe non utilizzati e gestione segnali
				close(p0p1[1]); close(p1p2[0]); close(p2p0[0]);
				close(p2p0[1]); close(fileIn);
				signal(SIGINT,handler_termp1);
				
				//Procedura di lettura da pipe e scarto delle lettere in posizione
				//multipla di num1. Alternativa ancora più semplice: leggere 1 car alla volta
				while((num=read(p0p1[0],buffer,MAX))!=0) {
					for(i=0,j=0;i<num;i++,index++){
						if((index)%num1==0){scartato[0]=buffer[i];write(fileScartati,scartato,1);}
						else outbuffer[j++]=buffer[i];
						}	
					write(p1p2[1],outbuffer,j);	
					}
				handler_termp1(1);	
				}
	else{
		//Codice del processo padre
		if((pid2=fork())<0) {
			perror("Errore nella fork:");
			exit(-5);
			}
	
		if(pid2==0) {	
					int num=0,i=0,j=0,index=1;
					char buffer[MAX];
					char outbuffer[MAX];
					char scartato[1];
					
					//Codice di P2
					//Chiusura di file e pipe non utilizzati e gestione segnali
					close(p0p1[0]);
					close(p0p1[1]);
					close(p1p2[1]);
					close(p2p0[0]);
					close(fileIn);
					
					signal(SIGINT,handler_termp2);
					
					//Procedura di lettura da pipe e scarto delle letter in posizione
					//multipla di num2
					while((num=read(p1p2[0],buffer,MAX))!=0) {
						write(1,"P2 ha letto\n",12);
						write(1,buffer,MAX);
						for(i=0,j=0;i<num;i++,index++){
							if((index)%num2==0){scartato[0]=buffer[i];write(fileScartati,scartato,1);}
							else outbuffer[j++]=buffer[i];
							}	
						write(p2p0[1],outbuffer,j);	
						}
					handler_termp2(1);	
					}
		else {
			  char buffer[MAX];
			  int i=0,tot=0,temp=0,num=0;
			  int len_in=0,len_scart=0;
			  //Codice processo padre
			  //Chiusura di file e pipe non utilizzati e gestione segnali
			  close(p0p1[0]); close(p1p2[0]);
			  close(p1p2[1]); close(p2p0[1]);
			  signal(SIGINT,handler_term_int);
			
			  //Lettura da file di blocchi di dimensione MAX e scrittura su pipe
			  while((num=read(fileIn,buffer,MAX))!=0) {
					write(p0p1[1],buffer,num);
					//Questa sleep ci permette di testare il funzionamento del sistema nel caso venga premuto CTRL+C
					//sleep(1); 
					}
			  close(p0p1[1]);		
			  while((temp=read(p2p0[0],buffer,MAX))!=0) 	tot_ricevuti+=temp;
			
			  //Chiusura pipe ed attesa terminazione figli
			  close(p2p0[0]);
			  wait_child();
			  wait_child();				
			  //Controllo della consistenza delle operazioni
			  len_in=lseek(fileIn,0,SEEK_END);
			  len_scart=lseek(fileScartati,0,SEEK_END);
			  if(len_in!=len_scart+tot_ricevuti) {write(1,"\n\nSi e' verificato un errore\n\n",16); }
			  //Operazione di debugging: scrittura a video dei dati relativi alle operazioni effettuate
			  printf("in:%d scart:%d temp:%d\n",len_in,len_scart,tot_ricevuti);
			  fflush(stdout);						
			  //Chiusura 
			  close(fileIn); close(fileScartati);																													
			 }
		}	//Chiusura ELSE 		
	
}

/*Handler per gestire*/
void handler_term_int(int signo){
	  int len_in=0,len_scart=0,i=0,j=0,num=0,curr=0,index=0;
	  char buffer[MAX],outbuffer[MAX];
	  char scartato[1];
	  
	  /* Operazioni del padre: una soluzione possibile è quella di cercare di 
	   eliminare i caratteri in posizione multipla di num1 
	   (contando a partire dall'inizio del file) - comportamento di p1-, e i caratteri in posizione
	   num2, a partire dal primo che non viene filtrato - comportamento di p2- */
	  index=lseek(fileIn,0,SEEK_CUR)+1;
	  while((num=read(fileIn,buffer,MAX))!=0) {
			 for(i=0,j=0;i<num;i++,index++){
				if((index)%num1==0){scartato[0]=buffer[i];write(fileScartati,scartato,1);}
				else outbuffer[j++]=buffer[i];
				}
			 index=1;
			 curr=j;	
			 for(i=0;i<j;i++,index++){
				if((index)%num2==0){curr--;scartato[0]=outbuffer[i];write(fileScartati,scartato,1);}
				}			
			tot_ricevuti+=curr;		
			index=lseek(fileIn,0,SEEK_CUR)+1;
		}
		
	  //Controllo della consistenza delle operazioni			  
	  len_in=lseek(fileIn,0,SEEK_END);
	  len_scart=lseek(fileScartati,0,SEEK_END);
	  printf("in:%d scart:%d temp:%d\n",len_in,len_scart,tot_ricevuti);	 
	  //Chiusura di pipe, file, ed attesa delle terminazioni dei figli
	  close(p2p0[0]);
	  wait_child();
	  wait_child();				
	  close(fileIn); close(fileScartati);
	  exit(0);
}

//Handler di terminazione dei due processi p1 e p2
void handler_termp1(int signo) {
	close(fileScartati); close(p0p1[0]);
	close(p1p2[1]); exit(0);
}
void handler_termp2(int signo) {
	close(fileScartati); close(fileIn);
	close(p2p0[1]); close(p1p2[0]);
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