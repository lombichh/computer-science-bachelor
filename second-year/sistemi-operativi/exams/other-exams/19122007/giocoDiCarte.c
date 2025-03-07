#include <stdio.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>


int p1p0[2],p2p0[2];

int fd_out,fd_in;

char fileIn[200],fileOut[200];
void wait_child();
int prese[3];
int numero_mano=0;
int pid0,pid1,pid2;
int decretaVittoriaFinale(int numeroPreseVinte, int numeroPreseEffettuate);
int decretaVincitoreMano(int carta[]);
void handler_presa(int s);
void handler_term(int s);
void termina();


int main (int argc, char* argv[]){	

	// Controllo parametri
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
	
	strcpy(fileIn, argv[1]);
	strcpy(fileOut, argv[2]);
					
	//Parent PID
	pid0=getpid();

	//Creazione delle pipe P0-->P1 (comunicazione carta giocata da P1)
	if (pipe(p1p0)<0){ printf("Errore nella creazione della pipe da P0 a P1\n");exit(-1); }

	//Creazione delle pipe P0-->P2 (comunicazione carta giocata da P2)
	if (pipe(p2p0)<0){ printf("Errore nella creazione della pipe da P0 a P2\n");exit(-1);}

	//Apertura file di output
	if ((fd_out = open (fileOut,O_WRONLY | O_CREAT , 0777))<0) {perror("Error opening file");exit(-1);}
	
	signal(SIGTSTP, handler_term);
	signal(SIGINT,handler_term);
	pid1 = fork();
	if (pid1 < 0){perror ("Errore nella fork");exit(-2);}
	if (pid1 == 0){
		//nella variabile globale pid1 il padre P0 ha effettivamente il PID di P1, senza la istruzione seguente, invece, pid1 ha il valore nello spazio di indirizzamento di P1 ha valore 0.
		pid1 = getpid();
		pid2 = fork();
		if (pid2 < 0){perror ("Errore nella fork");exit(-2);}
		if (pid2 == 0){//Codice di P2
				//vedi sopra
				pid2 = getpid();
				close(p1p0[0]);	
				close(p1p0[1]);
				close(p2p0[0]);
				signal(SIGUSR1, handler_presa);
				signal(SIGUSR2, handler_presa);
				int current_pid = getpid();
				write(p2p0[1],&current_pid,sizeof(int));

								
				if ((fd_in = open (fileIn,O_RDONLY))<0) {perror("Error opening file");exit(-1);}
				int riga_corrente;
				for( riga_corrente=0; riga_corrente<39; riga_corrente++) {
					int seme,numero,letti;
					if ((letti=read(fd_in,&numero,sizeof(int)))<0) 
						{perror("P2: Errore nella lettura del seme da file");exit(-1);}
					if ((letti=read(fd_in,&seme,sizeof(int)))<0) 
						{perror("P2: Errore nella lettura del numero da file");exit(-1);}
					if (riga_corrente>25){
						write(p2p0[1],&numero,sizeof(int));
						write(p2p0[1],&seme,sizeof(int));
						pause();
					}
				}
				termina();
		}
		else{//Codice di P1
			close(p1p0[0]);	
			close(p2p0[0]);
			close(p2p0[1]);
			signal(SIGUSR1, handler_presa);
			signal(SIGUSR2, handler_presa);

			if ((fd_in = open (fileIn,O_RDONLY))<0) {perror("Error opening file");exit(-1);}
			int riga_corrente;
			for( riga_corrente=0; riga_corrente<39; riga_corrente++) {
				int seme,numero,letti;
				if ((letti=read(fd_in,&numero,sizeof(int)))<0) 
					{perror("P1: Errore nella lettura del seme da file");exit(-1);}
				if ((letti=read(fd_in,&seme,sizeof(int)))<0) 
					{perror("P1: Errore nella lettura del numero da file");exit(-1);}
				if (riga_corrente>12 && riga_corrente<=25){
					write(p1p0[1],&numero,sizeof(int));
					write(p1p0[1],&seme,sizeof(int));
					pause();
				}
			}
			termina();
		}
	}
	else {//Codice di P0
		close(p1p0[1]);	
		close(p2p0[1]);
		int numread;
		if ((numread=read(p2p0[0],&pid2,sizeof(int))) < 0){
			perror("Error reading pipe");
			exit(-1);
		}
		char log[30];
		sprintf(log,"PID 0 : %d\n",pid0);
		write(1,log,strlen(log));
		sprintf(log,"PID 1 : %d\n",pid1);
		write(1,log,strlen(log));
		sprintf(log,"PID 2 : %d\n",pid2);
		write(1,log,strlen(log));

		sleep(2);

		int carta_p0=0;
		int carta_p1=0;
		int carta_p2=0;
		int seme_p0=0;
		int seme_p1=0;
		int seme_p2=0;
		int vincitore_mano = -1;
		if ((fd_in = open (fileIn,O_RDONLY))<0) {perror("Error opening file");exit(-1);}
		while(numero_mano<13){
			int letti;
			if ((letti=read(fd_in,&carta_p0,sizeof(int)))<0) 
				{perror("P0: Errore nella lettura del numero da file");exit(-1);}
			if ((letti=read(fd_in,&seme_p0,sizeof(int)))<0) 
				{perror("P0: Errore nella lettura del seme da file");exit(-1);}

			if ((numread=read(p1p0[0],&carta_p1,sizeof(int))) < 0)
				{perror("Error reading pipe");exit(-1);}
			if ((numread=read(p2p0[0],&carta_p2,sizeof(int))) < 0)
				{perror("Error reading pipe");exit(-1);}
			if ((numread=read(p1p0[0],&seme_p1,sizeof(int))) < 0)
				{perror("Error reading pipe");exit(-1);}
			if ((numread=read(p2p0[0],&seme_p2,sizeof(int))) < 0)
				{perror("Error reading pipe");exit(-1);}
	char log[30];
	sprintf(log,"Mano %d\n\tP0: %d %d\n\tP1 %d %d\n\tP2 %d %d\n",numero_mano,carta_p0,seme_p0,carta_p1,seme_p1,carta_p2,seme_p2);
	write(1,log,strlen(log));
			int carte[]={carta_p0,carta_p1,carta_p2};
			vincitore_mano = decretaVincitoreMano(carte);
			if (vincitore_mano == 0) {
				kill (pid1,SIGUSR2);//segnalazione sconfitta
				kill (pid2,SIGUSR2);//segnalazione sconfitta
				prese[0]++;
				strcpy(log,"Vincitore: P0\n");
				write(1,log,strlen(log));
			}
			else if (vincitore_mano == 1){
				kill (pid1,SIGUSR1);//segnalazione vittoria
				kill (pid2,SIGUSR2);//segnalazione sconfitta
				strcpy(log,"Vincitore: P1\n");
				write(1,log,strlen(log));

			}
			else if (vincitore_mano == 2){
				kill (pid1,SIGUSR2);//segnalazione sconfitta
				kill (pid2,SIGUSR1);//segnalazione vittoria
				strcpy(log,"Vincitore: P2\n");
				write(1,log,strlen(log));

			}
			else {
				strcpy(log,"Vincitore: nessuno!\n");
				write(1,log,strlen(log));
			
			}
			numero_mano++;
			sleep(1);
		}
		termina();
	}

}

/*
 * Si suppone che non si verifichi mai una condizione di pareggio e cioè che due o più processi 
 * abbiano durante una mano la carta di numero più alto (di seme ovviamente diverso).
 *
 */
int decretaVincitoreMano(int carta[]){

	if (carta[2]> carta[1] && carta[2]> carta[0])
		return 2;
	else if (carta[1]> carta[2] && carta[1]> carta[0])
		return 1;
	else if (carta[0]> carta[2] && carta[0]> carta[1])
		return 0;
	else return -1;

}

/*
 * Si suppone che non si verifichino mai condizioni di pareggio (ad esempio, 10 mani effettuate, P1 e P2 4 prese, P0 2 
 * prese).
 */
int decretaVittoriaFinale(int numeroPreseVinte, int numeroPreseEffettuate){
	if (numeroPreseVinte >=  1 + (numeroPreseEffettuate/3))
		return 1;
	else 
		return 0;
}
void termina(){
	char file_log[100] ="";
	char log2[100] ="";
	int processo = -1;
	if (pid0 == getpid())
		processo =0;
	else if (pid1 == getpid())
		processo =1;
	else if (pid2 == getpid())
		processo =2;
	int vittoria = decretaVittoriaFinale(prese[processo],numero_mano);
	char stringa_risultato[100];
	if (vittoria > 0)
		sprintf(file_log,"\nSono il processo PID%d (%d) e ho vinto :-)\n",processo,getpid());
	else
		sprintf(file_log,"\nSono il processo PID%d (%d) e ho perso :-(\n",processo,getpid());
	write(fd_out,file_log,strlen(file_log));

	sprintf(log2,"Sono il processo PID%d (%d) : ho preso %d volte su %d \n",processo,getpid(),prese[processo],numero_mano);
	write(1,log2,strlen(log2));
	close(fd_in);
	close(fd_out);

	if (pid0 == getpid()){
		close(p1p0[0]);	
		close(p2p0[0]);
		wait_child();
	}
	else if (pid1 == getpid()){
		close(p1p0[1]);	
		wait_child();
	}
	else if (pid2 == getpid())
		close(p2p0[1]);	

	exit(1);
}
void handler_term(int s){
	char log[100];
	if (s == SIGTSTP && getpid() == pid1)
		strcpy(log,"Uscita dal gioco di : PID1\n");
	else if(s == SIGINT && getpid() == pid2)
		strcpy(log,"Uscita dal gioco di : PID2\n");
	write(1,log,strlen(log));
	termina();
}

void handler_presa(int s){
	int currentpid = getpid();
	if (currentpid == pid1){
		if (s == SIGUSR1)
			prese[1]++;
		numero_mano++;		
	}
	else if (currentpid == pid2){
		if (s == SIGUSR1)
			prese[2]++;
		numero_mano++;
	}	
}

void wait_child() {
	char log[100];
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			sprintf(log,"\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			sprintf(log,"\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
	write(1,log,strlen(log));
}


