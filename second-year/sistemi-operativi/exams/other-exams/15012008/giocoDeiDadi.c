#include <stdio.h>
#include <sys/wait.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>


/*
I processi P0 e P1 incrementano lo stato del contatore delle proprie vincite a seguito della ricezione di un segnale SIGUSR1
Al termine della esecuzione, ogni processo sa di aver vinto o perso sulla base del rapporto tra lanci vinti e lanci effettuati ed è in grado di scrivere direttamente su file il proprio risultato.
Questa soluzione tuttavia impone una sequenzializzazione: i processi P0 e P1 devono ad ogni turno attendere l'arrivo di un segnale di vittoria o sconfitta inviato da P2.

Sarebbe possibile fare cadere questo vincolo? Come si potrebbe farlo? Lo studente cerchi di elaborare una soluzione alternativa che vada in tal senso.

*/

int p0p2[2],p1p2[2];

int fd_out,fd_in;

char fileIn[200],fileOut[200];
void wait_child();
int turniVinti[3];
int numero_turno=0;
int pid0,pid1,pid2;
int decretaVittoriaFinale(int numeroTurniVinti, int numeroTurniEffettuati);
int decretaVincitoreTurno(int lancio[]);
void handler_turno(int s);
void handler_term_p0(int s);
void handler_term_p1(int s);
void handler_term_p2(int s);
void termina(int p);


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

	//Creazione delle pipe P0-->P2 (comunicazione lancio di P0)
	if (pipe(p0p2)<0){ printf("Errore nella creazione della pipe da P0 a P2\n");exit(-1); }

	//Creazione delle pipe P1-->P2 (comunicazione lancio di P1)
	if (pipe(p1p2)<0){ printf("Errore nella creazione della pipe da P1 a P2\n");exit(-1);}

	//Apertura file di output
	if ((fd_out = open (fileOut,O_WRONLY | O_CREAT , 0777))<0) {perror("Error opening file");exit(-1);}


	pid1=fork();
	if (pid1 < 0){perror ("Errore nella fork");exit(-2);}
	if (pid1 > 0){
		pid2=fork();
		if (pid2 < 0){perror ("Errore nella fork");exit(-2);}
		if (pid2 > 0){//Codice P0
			signal(SIGTSTP, handler_term_p0);
			signal(SIGINT,handler_term_p0);
			signal(SIGUSR1,handler_turno);
			signal(SIGUSR2,handler_turno);
			close(p0p2[0]);
			close(p1p2[0]);
			close(p1p2[1]);
			char log[30];
			sprintf(log,"PID 0 : %d\n",pid0);
			write(1,log,strlen(log));
			sprintf(log,"PID 1 : %d\n",pid1);
			write(1,log,strlen(log));
			sprintf(log,"PID 2 : %d\n",pid2);
			write(1,log,strlen(log));

			if ((fd_in = open (fileIn,O_RDONLY))<0) {perror("Error opening file");exit(-1);}
			int riga_corrente;
			for( riga_corrente=0; riga_corrente<29; riga_corrente++) {
				int letti, dado1, dado2, somma;
				char buf[4];
				if ((letti=read(fd_in,buf,sizeof(buf)))<0) 
					{perror("P1: Errore nella lettura del lancio");exit(-1);}
				dado1 = atoi(&buf[0]);
				dado2 = atoi(&buf[2]);				
				somma = dado1 + dado2;
				if (riga_corrente>=0 && riga_corrente<=9){
					write(p0p2[1],&somma,sizeof(int));
					pause();
				}
			}
			termina(0);//terminazione del processo P0
		}
		else {//Codice P2
			signal(SIGTSTP, handler_term_p2);
			signal(SIGINT,handler_term_p2);
			close(p1p2[1]);
			close(p0p2[1]);

			sleep(2);

			if ((fd_in = open (fileIn,O_RDONLY))<0) {perror("Error opening file");exit(-1);}

			int riga_corrente,i,lancio_p0,lancio_p1, letti;
			char buf[4];
			
			for (i= 0; i<20; i++) // consumo le prime 20 righe del file.
				if ((letti=read(fd_in,buf,sizeof(buf)))<0) 
					{perror("P1: Errore nella lettura del lancio");exit(-1);}

			while(numero_turno<10){

				int letti, dado1, dado2, lancio_p2;

				if ((letti=read(fd_in,buf,sizeof(buf)))<0) 
					{perror("P1: Errore nella lettura del lancio");exit(-1);}
				dado1 = atoi(&buf[0]);
				dado2 = atoi(&buf[2]);				
				lancio_p2 = dado1 + dado2;


				if ((letti=read(p0p2[0],&lancio_p0,sizeof(int))) < 0)
					{perror("Error reading pipe");exit(-1);}
				if ((letti=read(p1p2[0],&lancio_p1,sizeof(int))) < 0)
					{perror("Error reading pipe");exit(-1);}


				char log[30];
				sprintf(log,"Lancio %d\n\tP0: %d \n\tP1 %d \n\tP2 %d \n",numero_turno,lancio_p0,lancio_p1,lancio_p2);
				write(1,log,strlen(log));
				int lanci[]={lancio_p0,lancio_p1,lancio_p2};
				int vincitore_turno = decretaVincitoreTurno(lanci);

				if (vincitore_turno == 0) {
					kill (pid1,SIGUSR2);//segnalazione sconfitta
					kill (pid0,SIGUSR1);//segnalazione vittoria

					strcpy(log,"Vincitore: P0\n");
					write(1,log,strlen(log));
				}
				else if (vincitore_turno == 1){
					kill (pid1,SIGUSR1);//segnalazione vittoria
					kill (pid0,SIGUSR2);//segnalazione sconfitta
					strcpy(log,"Vincitore: P1\n");
					write(1,log,strlen(log));

				}
				else if (vincitore_turno == 2){
					kill (pid0,SIGUSR2);//segnalazione sconfitta
					kill (pid1,SIGUSR2);//segnalazione sconfitta
					turniVinti[2]++;
					strcpy(log,"Vincitore: P2\n");
					write(1,log,strlen(log));
				}
				else {
					strcpy(log,"Vincitore: nessuno!\n");
					write(1,log,strlen(log));
				}
				numero_turno++;
				sleep(1);
			
			}//while

			termina(2);//terminazione del processo P2		
		}
	}
	else{//codice P1
			pid1=getpid();
			close(p0p2[0]);
			close(p1p2[0]);
			close(p0p2[1]);

			signal(SIGTSTP, handler_term_p1);
			signal(SIGINT,handler_term_p1);
			signal(SIGUSR1,handler_turno);
			signal(SIGUSR2,handler_turno);
			
			if ((fd_in = open (fileIn,O_RDONLY))<0) {perror("Error opening file");exit(-1);}
			int riga_corrente;
			for( riga_corrente=0; riga_corrente<29; riga_corrente++) {
				int letti, dado1, dado2, somma;
				char buf[4];
				if ((letti=read(fd_in,buf,sizeof(buf)))<0) 
					{perror("P1: Errore nella lettura del lancio");exit(-1);}
				dado1 = atoi(&buf[0]);
				dado2 = atoi(&buf[2]);				
				somma = dado1 + dado2;
				if (riga_corrente>9 && riga_corrente<=19){
					write(p1p2[1],&somma,sizeof(int));
					pause();
				}
			}
			termina(1);//terminazione del processo P1	
	}

}	

/*
 * Si suppone che non si verifichi mai una condizione di pareggio e cioè che due o più processi 
 * abbiano durante una mano il lancio  più alto.
 *
 */
int decretaVincitoreTurno(int lancio[]){

	if (lancio[2]> lancio[1] && lancio[2]> lancio[0])
		return 2;
	else if (lancio[1]> lancio[2] && lancio[1]> lancio[0])
		return 1;
	else if (lancio[0]> lancio[2] && lancio[0]> lancio[1])
		return 0;
	else return -1;

}

/*
 * Si suppone che non si verifichino mai condizioni di pareggio (ad esempio, 10 lanci effettuati, P1 e P2 4 vittorie, P0 2 
 * vitori).
 */
int decretaVittoriaFinale(int numeroTurniVinti, int numeroTurniEffettuati){
	if (numeroTurniVinti >=  1 + (numeroTurniEffettuati/3))
		return 1;
	else 
		return 0;
}

/*Logica comune di terminazione*/
void termina(int processo){
	/* processo compreso tra 0 e 2*/
	if (processo < 0 || processo > 2){
		perror("Errore non previsto: processo fuori range");
		exit(-2);
	}
	char file_log[100] ="";
	char log2[100] ="";
	int vittoria = decretaVittoriaFinale(turniVinti[processo],numero_turno);
	char stringa_risultato[100];
	if (vittoria > 0)
		sprintf(file_log,"\nSono il processo PID%d (%d) e ho vinto :-)\n",processo,getpid());
	else
		sprintf(file_log,"\nSono il processo PID%d (%d) e ho perso :-(\n",processo,getpid());
	write(fd_out,file_log,strlen(file_log));

	sprintf(log2,"Sono il processo PID%d (%d) : ho preso %d volte su %d \n",processo,getpid(),turniVinti[processo],numero_turno);
	write(1,log2,strlen(log2));

	if (processo == 0){
		close(p0p2[1]);
		wait_child();
		wait_child();
	}
	else if (processo == 1){
		close(p1p2[1]);	
	}
	else if (processo == 2){
		close(p0p2[0]);	
		close(p1p2[0]);	
	}
	close(fd_in);
	close(fd_out);
	exit(1);
}
void handler_term_p2(int s){
	termina(2);
}
void handler_term_p1(int s){
	if (s == SIGTSTP){
		char log[100];
		strcpy(log,"Uscita dal gioco di : PID1\n");
		write(1,log,strlen(log));
	}
	termina(1);
}
void handler_term_p0(int s){
	if(s == SIGINT){
		char log[100];
		strcpy(log,"Uscita dal gioco di : PID0\n");
		write(1,log,strlen(log));
	}
	termina(0);
}


void handler_turno(int s){
	int currentpid = getpid();
	if (currentpid == pid0){
		if (s == SIGUSR1)
			turniVinti[0]++;
		numero_turno++;		
	}
	else if (currentpid == pid1){
		if (s == SIGUSR1)
			turniVinti[1]++;
		numero_turno++;
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


