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
int leggi_cartella(int* scheda, int low, int high, int filein);
void scrivi_punti(int fileout, int pid, int punti);
void handler_fortunello(int signo);
void handler_term0(int signo);
void handler_term1(int signo);
void handler_term2(int signo);
void handler_term3(int signo);
void termina0();
void termina1();
void termina2();
void termina3();



int punti;
int p1p0[2],p2p0[2],p3p0[2];
int pid0,pid1,pid2,pid3;
int p0p1[2],p0p2[2],p0p3[2];
int p3p1[2];
int filein,fileout;
int cinquina=0,decina=0,tombola=0;

int
main(int argc, char* argv[])
{ 
	int numread=0;
	int estratto=-1,trovato=0,index=0;
	
	int scheda[15];
		
	//1) Controllo parametri
	if(argc!=3) {
		printf("usage: %s <fileIn> <fileOut>\n",argv[0]);
		exit(-1);
	}
	if (argv[1][0]!='/'){
		printf("Il primo argomento deve essere un nome assoluto\n");
		exit(-1);
	}
	if (argv[2][0]=='/'){
		printf("Il secondo argomento non deve essere un nome assoluto\n");
		exit(-1); 
	}
	

	if((fileout=open(argv[2],O_WRONLY))<0) {
		perror("Error opening file:");
		exit(-1);
	}

	//Apertura pipe da parte del padre
	if (pipe(p0p1)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-1);
		} //P0 --> P1
	if (pipe(p0p2)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-1);
		} //P0 --> P2
	if (pipe(p0p3)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-1);
		} //P0 --> P3	
		
	//Apertura pipe da parte del padre
	if (pipe(p1p0)<0){
			printf("Errore nella creazione della prima pipe\n");
			exit(-1);
		} //P1 --> P0
	if (pipe(p2p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-1);
		} //P2 --> P0
	if (pipe(p3p0)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-1);
		} //P3 --> P0			
		
	if (pipe(p3p1)<0){
			printf("Errore nella creazione della seconda pipe\n");
			exit(-1);
		} //P3 --> P1
					
	//Parent PID
	pid0=getpid();
	
	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-2);
	}
	
	if(pid1==0) {		
			pid1=getpid();
			//Generazione del processo P2 (nipote di P0)
			if((pid2=fork())<0){
				perror("Errore nella seconda fork:");
				exit(-2);
			}
			if(pid2==0){
				pid2=getpid();
				//Generazione del processo P3 (pro-nipote di P0)
				if((pid3=fork())<0){
					perror("Errore nella seconda fork:");
					exit(-2);
				}
				if(pid3==0){
						close(p0p1[0]); close(p0p1[1]); close(p0p2[0]);	
						close(p0p2[1]); close(p0p3[1]); close(p1p0[0]);
						close(p1p0[1]); close(p2p0[0]); close(p2p0[1]);
						close(p3p0[0]); close(p3p1[0]);
						
						signal(SIGUSR1, handler_fortunello);
						signal(SIGINT, handler_term3);
						
						if((filein=open(argv[1],O_RDONLY))<0) {
							perror("Error opening file:");
							exit(-1);
							}
						
						pid3=getpid();
	
						write(p3p1[1],&pid3,sizeof(int));
						close(p3p1[1]);
						
						
						while(((numread=read(p0p3[0],&estratto,sizeof(int)))>0)&&!tombola){
							trovato=0;
							index=0;
							leggi_cartella(scheda,30,49,filein);
							while(!trovato && index<15){
								if(estratto==scheda[index])trovato=1;
								index++;
							}
							if(trovato)punti++;
							if((punti==5 && cinquina==0) ||
								(punti==10 && decina==0) ||
								(punti==15 && tombola==0)){
									if(cinquina==0) cinquina=1;
									else if (decina==0) decina=1;
									else if (tombola==0) tombola=1;
									scrivi_punti(fileout,getpid(),punti);
									kill(pid1,SIGUSR1);
									kill(pid2,SIGUSR1);
									kill(pid0,SIGUSR1);									
								}		
						}
						termina3();
				}//end pid3
				
				else {
					/*Codice di pid2*/
					close(p0p1[0]); close(p0p1[1]); close(p0p2[1]);
					close(p0p3[0]); close(p0p3[1]); close(p1p0[0]);
					close(p1p0[1]); close(p2p0[0]); close(p3p0[0]);
					close(p3p0[1]); close(p3p1[0]); close(p3p1[1]);
					
					signal(SIGUSR1, handler_fortunello);
					signal(SIGINT, handler_term2);
					
					if((filein=open(argv[1],O_RDONLY))<0) {
						perror("Error opening file:");
						exit(-1);
						}
					
					
					while(((numread=read(p0p2[0],&estratto,sizeof(int)))>0) &&!tombola){
						trovato=0;
						index=0;
						leggi_cartella(scheda,15,29,filein);
						while(!trovato && index<15){
							if(estratto==scheda[index])trovato=1;
							index++;
						}
						if(trovato)punti++;
						if((punti==5 && cinquina==0) ||
							(punti==10 && decina==0) ||
							(punti==15 && tombola==0)){
								if(cinquina==0) cinquina=1;
								else if (decina==0) decina=1;
								else if (tombola==0) tombola=1;					
								scrivi_punti(fileout,getpid(),punti);
								kill(pid1,SIGUSR1);
								kill(pid3,SIGUSR1);
								kill(pid0,SIGUSR1);	
							}		
					}
				   termina2();
				} //end pid2
			 }//end if pid2==0
	
		else {
			/*Codice di pid1*/
			close(p0p1[1]); close(p0p2[0]); close(p0p2[1]);
			close(p0p3[0]); close(p0p3[1]); close(p1p0[0]);
			close(p2p0[0]); close(p2p0[1]); close(p3p0[0]);
			close(p3p0[1]); close(p3p1[1]); 
		
			signal(SIGUSR1, handler_fortunello);
			signal(SIGINT, handler_term1);
			
			if((filein=open(argv[1],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
				}
			
			if((numread=read(p3p1[0],&pid3,sizeof(int)))<0){
				perror("Errore in lettura:");
				exit(-1);
				}
			close(p3p1[0]);
			
			
			while(((numread=read(p0p1[0],&estratto,sizeof(int)))>0)&&!tombola){/Perché questa istruzione potrebbe non essere safe? 
				trovato=0;
				index=0;
				leggi_cartella(scheda,0,14,filein);
				while(!trovato && index<15){
					if(estratto==scheda[index])trovato=1;
					index++;
				}
				
				if(trovato)punti++;
				if((punti==5 && cinquina==0) ||
					(punti==10 && decina==0) ||
					(punti==15 && tombola==0)){
						if(cinquina==0) cinquina=1;
						else if (decina==0) decina=1;
						else if (tombola==0) tombola=1;
						scrivi_punti(fileout,getpid(),punti);
						kill(pid3,SIGUSR1);
						kill(pid2,SIGUSR1);
						kill(pid0,SIGUSR1);									
					}		
			}
			termina1();
			
			
		}//end pid1
	 }//end if pid1==0	
	
	else	{
	/*Codice di p0*/
	close(p0p1[0]); close(p0p2[0]); close(p0p3[0]);
	close(p1p0[1]); close(p2p0[1]); close(p3p0[1]);
	close(p3p1[0]); close(p3p1[1]);
	
	signal(SIGUSR1, handler_fortunello);
	signal(SIGINT, handler_term0);
	
	while(!tombola){ 
		estratto=rand()%90+1;
		write(p0p1[1],&estratto,sizeof(int));
		write(p0p2[1],&estratto,sizeof(int));
		write(p0p3[1],&estratto,sizeof(int));	
		sleep(1);	
		}
	
	}
}

int leggi_cartella(int* scheda, int low, int high, int filein){
	int numread=0;
	int i=0;
	int curr=-1;
	lseek(filein,low*sizeof(int),SEEK_SET);
	for(i=0;i<high-low;i++){
		if((numread=read(filein,&curr,sizeof(int)))<0){
			perror("Errore di lettura da file:");
			exit(-1);
			}
		scheda[i]=curr;	
	}
}

void scrivi_punti(int fileout, int pid, int punti){
	char punt[81],buffer[81];
	sprintf(buffer,"Sono il processo con il pid %d e ho fatto ",pid);
	if(punti==5){sprintf(punt,"cinquina\n");}
	else if (punti==10){sprintf(punt,"decina\n");}
	else {sprintf(punt,"tombola\n");}
	strcat(buffer,punt);
	write(fileout,buffer,strlen(buffer));	
	//toglierer
	write(1,buffer,strlen(buffer));
}
	

/*GESTORI DI SIGUSR1*/
void
handler_fortunello(int signo){
	int mypid=getpid();
	if(!cinquina)cinquina=1;
	else if(!decina) decina=1;
	else if(!tombola) {
			tombola=1;
			if(mypid==pid1)termina1();
			else if(mypid==pid2)termina2();
			else if(mypid==pid3)termina3();
			else if(mypid==pid0)termina0();
		}
}


/*GESTORI DI SIGINT*/
void
handler_term0(int signo){
	int punti1, punti2, punti3, numread;
	char buffer[81];
	if((numread=read(p1p0[0],&punti1,sizeof(int)))<0){
			perror("Errore in lettura:");
			exit(-1);
	}
	if((numread=read(p2p0[0],&pid2,sizeof(int)))<0){
			perror("Errore in lettura:");
			exit(-1);
	}
	if((numread=read(p2p0[0],&punti2,sizeof(int)))<0){
			perror("Errore in lettura:");
			exit(-1);
	}
	if((numread=read(p3p0[0],&pid3,sizeof(int)))<0){
			perror("Errore in lettura:");
			exit(-1);
	}
	if((numread=read(p3p0[0],&punti3,sizeof(int)))<0){
			perror("Errore in lettura:");
			exit(-1);
	}
	/*Scrittura su file*/
	ftruncate(fileout,0);
	if(punti1>=punti2 && punti1>=punti3){
			sprintf(buffer, "Gioco terminato. Ha vinto il processo con pid %d di cui erano giˆ stati estratti %d numeri\n",
							pid1,punti1);
		}
	else if(punti2>=punti1 && punti2>=punti3){
			sprintf(buffer, "Gioco terminato. Ha vinto il processo con pid %d di cui erano giˆ stati estratti %d numeri\n",
							pid2,punti2);
		}		
	else {
			sprintf(buffer, "Gioco terminato. Ha vinto il processo con pid %d di cui erano giˆ stati estratti %d numeri\n",
							pid3,punti3);
		}	
	write(fileout,buffer,strlen(buffer));
	termina0();
}

void termina0(){	
	//togliere 
	printf("processo %d esce\n",getpid());
	close(p0p1[1]); close(p0p2[1]); close(p0p3[1]);
	close(p1p0[0]); close(p2p0[0]); close(p3p0[0]);
	close(filein); close(fileout); 
	wait_child();	
	exit(0);
}	

void 
handler_term1(int signo){
	write(p1p0[1],&punti,sizeof(int));
	termina1();
}

void termina1(){	
		//togliere 
	printf("processo %d esce\n",getpid());
	close(p0p1[0]); close(p1p0[1]); close(filein);
	close(fileout);
	wait_child();
	exit(0);
}

void 
handler_term2(int signo){
	write(p2p0[1],&pid2,sizeof(int));
	write(p2p0[1],&punti,sizeof(int));
	termina2();
}
void termina2(){	
		//togliere 
	printf("processo %d esce\n",getpid());
	close(p0p2[0]); close(p2p0[1]); close(filein);
	close(fileout);
	wait_child();
	exit(0);
}

void 
handler_term3(int signo){
	write(p3p0[1],&pid3,sizeof(int));
	write(p3p0[1],&punti,sizeof(int));
	termina3();
}
void termina3(){
	//togliere 
	printf("processo %d esce\n",getpid());
	close(p0p3[0]); close(p3p0[1]); close(filein);
	close(fileout);
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