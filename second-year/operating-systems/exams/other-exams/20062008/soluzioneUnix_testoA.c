#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>
#include <sys/wait.h>


void wait_child();
void handler_term(int signum);
void handler_suspend(int signum);
void handler_resume(int signum);
void handler_priority(int signum);
void termina_lettura_p1(int status);
void termina_lettura_p2(int status);
void termina_p1();
void termina_p2();

int pid0,pid1,pid2;
int sigint_count = 0;
int p1p2[2],p0p1[2],p0p2[2],p_ordinary[2],p_priority[2];
int fd_in,fd_out;
int blocked = 0;
int statoLettura = 0;
int N;
int lineNumber = 0;
int bytesRead= 0, charNumber =-1;
char c; char buffer[100];
int terminating = 0;

/*

Sincronizzazione per scrittura ordinata (supponendo che P1 abbia trovato stringa prioritaria):

	P1 : scrive su pipe prioritaria
	P1 --> SIGUSR1 a P0 per notificare contenuto sulla pipe prioritaria
	P1 --> SIGUSR1 a P2 per richiedere la sospensione dell'attività di P2
	P1 pause()

	P0 : lettura da pipe prioritaria e scrittura su file report.txt
	P0 --> SIGUSR2 a P1 per sbloccare P1 dalla pausa
	P0 pause()

	P1 --> scrittura su file report.txt
	P1 --> SIGUSR2 a P2 per sbloccare P2 dalla pausa
	P1 --> SIGUSR2 a P0 per sbloccare P0 dalla pausa

NOTA relativa alla terminazione tramite CTRL-C:

	Nella soluzione proposta, all'atto della pressione di CTRL-C una volta, il processo P1 (o analogamente P2 in caso di doppia pressione) si incarica di leggere sia la porzione di file rimanente di propria pertinenza, sia quella non ancora letta dall'altro processo figlio.
	Ai fini dell'esame, è stata considerata corretta comunque anche una soluzione nella quale ciascuno dei due figli termini soltanto la parte di propria pertinenza.

*/

int main(int argc, char** argv){

	pid0 = getpid();
	signal(SIGINT,handler_term);
	signal(SIGUSR1,handler_priority);
	signal(SIGUSR2,handler_priority);

	if (argc!=3) {
		printf("Usage :\n./soluzioneA <fileIn> <fileOut>\n");
		exit(-1);
	}

	if (argv[1][0]!='/'){
		printf("Il primo argomento deve essere un nome assoluto di file esistente\n");
		exit(-2);
	}

	if (argv[2][0] == '/'){
		printf("Il secondo argomento deve essere un nome relativo di file\n");
		exit(-2);
	}


	if((fd_out=open(argv[2],O_WRONLY|O_CREAT,0777))<0) {
		perror("Error opening file:");
		exit(-1);
	}

	if (pipe(p1p2)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	} // comunicazione stato di avanzamento lettura p1 e p2


	if (pipe(p_ordinary)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	} // comunicazione operazioni ordinarie

	if (pipe(p_priority)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	} // comunicazione operazioni prioritarie

	if (pipe(p0p1)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	} //P0 --> P1 : comunicazione del PID mancante a P1 (pid2) e di N

	if (pipe(p0p2)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	} //P0 --> P2 : comunicazione di N a P2

	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {//Figlio P1
		signal(SIGUSR1,handler_suspend);
		signal(SIGUSR2,handler_resume);
		pid1 = getpid();
		close(p_ordinary[0]);
		close(p_priority[0]);
		close(p0p1[1]);	close(p0p2[0]);	close(p0p2[1]);

		read(p0p1[0],&pid2,sizeof(int));
		read(p0p1[0],&N,sizeof(int));
		close(p0p1[0]);
		if((fd_in=open(argv[1],O_RDONLY))<0) {
			perror("Error opening file:");
			exit(-1);
		}
		termina_lettura_p1(-1);
		termina_p1();

	}
	else{
		if((pid2=fork())<0) {
			perror("Errore nella fork:");
			exit(-5);
		}
		if(pid2==0) {//Figlio P2
			signal(SIGUSR1,handler_suspend);
			signal(SIGUSR2,handler_resume);
			close(p_ordinary[0]);
			close(p_priority[0]);
			close(p0p1[0]); close(p0p1[1]);
			pid2 = getpid();
			close(p0p2[1]);
			read(p0p2[0],&N,sizeof(int));
			close(p0p2[0]);

			if((fd_in=open(argv[1],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}
			termina_lettura_p2(-1);
			termina_p2();

		}
		else{ //Padre P0
			close(p1p2[0]); close(p1p2[1]);
			close(p0p2[0]); close(p0p1[0]);
			close (p_ordinary[1]);
			close (p_priority[1]);

			char log[100];
			sprintf(log,"Pid0: %d\n",pid0);
			write(1,log,strlen(log));
			sprintf(log,"Pid1: %d\n",pid1);
			write(1,log,strlen(log));
			sprintf(log,"Pid2: %d\n",pid2);
			write(1,log,strlen(log));

			char c;
			int numBytes;
			//-----Comunicazione PID------------------------
			write(p0p1[1],&pid2,sizeof(int));

			//-----Apertura file input------------------------
			if((fd_in=open(argv[1],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}

			//-----Reperimento numero righe------------------------
			while((numBytes=read(fd_in,&c,sizeof(char)))>0){	
				if (c=='\n'){
					N++;
				}
			}
			close(fd_in);
			sleep(2);
			//-----Invio numero righe ai figli------------------------
			write(p0p1[1],&N,sizeof(int)) ;
			write(p0p2[1],&N,sizeof(int)) ;
			close (p0p1[1]); close (p0p2[1]);

			//-----Lettura pipe ordinarie------------------------
			int  charNumber = -1;
			char buffer[100];
			while((numBytes=read(p_ordinary[0],&c,sizeof(char)))>0){
				charNumber++;
				buffer[charNumber] = c;

				if (c=='\n'){
					buffer[strlen(buffer)] = '\0';
					write(fd_out,buffer,strlen(buffer));					
					charNumber=-1;
					strcpy(buffer,"");
				}

			}
			wait_child();
			wait_child();
			close (fd_out);
		}
	}

}

void handler_priority(int signum){

	signal (signum,handler_priority);

	char log[100];

	if (blocked == 1){
		blocked = 0;
	}
	else{
		blocked = 1;
		int  charNumber = -1, numBytes;
		char buffer[100];
		char c;
		while((numBytes=read(p_priority[0],&c,sizeof(char)))>0){
			charNumber++;
			buffer[charNumber] = c;
			if (c=='\n'){
				buffer[charNumber+1] = '\0';
				write(fd_out,buffer,strlen(buffer));					
				charNumber=-1;
				strcpy(buffer,"");
				break;
			}

		}

		if (signum == SIGUSR1){
			kill(pid1,SIGUSR2);
			pause();
		}
		if (signum == SIGUSR2 ){
			kill(pid2,SIGUSR2);
			pause();
		}
		return;
	}

}

void handler_suspend(int signum){
	signal (signum,handler_suspend);
	pause();
}

//Handler vuoto: il segnale corrispondente deve soltanto risvegliare un processo dalla pause
void handler_resume(int signum){
	signal (signum,handler_resume);
}


/*
	ATTENZIONE: il presente handler è stato progettato nell'ipotesi semplificativa di gestione reliable dei segnali con innestamento.
	Si ricorda che la gestione dei segnali in ambiente Linux al contrario è non-reliable, con blocco del segnale che ha scatenato l'handler per tutta l'esecuzione dell'handler e accodamento al più di un segnale.
*/
void handler_term(int signum){

	signal(signum,handler_term);

	sigint_count++;

	if(sigint_count == 1){
		sleep(1);
		if (pid1 == getpid()){
			//lettura da pipe dello stato di avanzamento di p1
			close(p1p2[1]);
			int status;
			read(p1p2[0],&status,sizeof(int));
			close(p1p2[0]);
			termina_lettura_p1(status);
			termina_p1();
		}
		else if (pid2 == getpid()){
			//scrittura su pipe dello stato di avanzamento di p2
			close(p1p2[0]);
			write(p1p2[1],&statoLettura,sizeof(int)) ;
			close(p1p2[1]);
			termina_p2();
		}
		
		
	}
	else if(sigint_count == 2){
		if (pid2 == getpid()){
			//lettura da pipe dello stato di avanzamento di p1
			close(p1p2[1]);
			int status=0;
			read(p1p2[0],&status,sizeof(int));
			close(p1p2[0]);
			termina_lettura_p2(status);
			termina_p2();
		}
		else if (pid1 == getpid()){
			//scrittura su pipe dello stato di avanzamento di p1
			close(p1p2[0]);
			write(p1p2[1],&statoLettura,sizeof(int)) ;
			close(p1p2[1]);
			termina_p1();
		}	
	}
}

/*
	status indica i byte correntemente letti dall'altro processo, per poter 
	terminare correttamente a seguito di un singolo o doppio CTRL-C
	se terminating >=0 --> ciclo di lettura normale
	se terminating == -1--> ciclo di lettura in a seguito di CTRL-C
*/
void termina_lettura_p2(int status){

	while((bytesRead=read(fd_in,&c,sizeof(char)))>0){
		if ( (lineNumber >= N/2 && lineNumber < N && terminating ==  0 ) || 
			(lineNumber >= 0 && lineNumber < N/2 && terminating ==  1 ) ){

			charNumber++;
			buffer[charNumber] = c;
			if (c == '\n'){
				statoLettura+=charNumber;
				sleep(1);
				buffer[charNumber+1] = '\0';
				char log[100];
				sprintf(log,"P2 legge riga %d (%d caratteri):%s",lineNumber,strlen(buffer),buffer);
				write(1,log,strlen(log));

				lineNumber++; charNumber=-1;
				if (buffer[0] =='p'){
					//Scrittura su PIPE prioritaria
					write(p_priority[1],buffer,strlen(buffer));
					kill(pid0,SIGUSR2);
					if (terminating == 0)
						kill(pid1,SIGUSR1);
					pause();
					write(fd_out,buffer,strlen(buffer));
					if (terminating == 0)
						kill(pid1,SIGUSR2);//sblocco l'altro processo
					kill(pid0,SIGUSR1);//sblocco il padre
				}
				else{
					//Scrittura su PIPE ordinaria
					write(p_ordinary[1],buffer,strlen(buffer));
				}
				strcpy(buffer,"");
			}
		}
		else if (c == '\n'){
			sleep(1);
			strcpy(buffer,"");
			lineNumber++; charNumber=-1;
		}
		else if (status >= 0 ){
			lseek(fd_in, status - 1,SEEK_SET); //riparto dall'inizio del file per leggere le righe non ancora lette da P1
			terminating = 1;
			status = 0;
		}
	}
}
void termina_lettura_p1(int status){
	while((bytesRead=read(fd_in,&c,sizeof(char)))>0){
		if ((lineNumber >= 0 && lineNumber < N/2) || (terminating == 1)){
			charNumber++;
			buffer[charNumber] = c;
			if (c == '\n'){
				statoLettura+=charNumber;
				sleep(1);
				buffer[charNumber+1] = '\0';
				char log[100];
				sprintf(log,"P1 legge riga %d (%d caratteri):%s",lineNumber,strlen(buffer),buffer);
				write(1,log,strlen(log));

				lineNumber++; charNumber=-1;
				if (buffer[0] =='p'){
					//Scrittura su PIPE prioritaria
					write(p_priority[1],buffer,strlen(buffer));
					kill(pid0,SIGUSR1);
					if (terminating == 0)
						kill(pid2,SIGUSR1);
					pause();
					write(fd_out,buffer,strlen(buffer));
					if (terminating == 0)
						kill(pid2,SIGUSR2);//sblocco l'altro processo
					kill(pid0,SIGUSR2);//sblocco il padre
				}
				else{
					//Scrittura su PIPE ordinaria
					write(p_ordinary[1],buffer,strlen(buffer));
				}
				strcpy(buffer,"");
			}
		}
		else if (status >= 0 ){
			lseek(fd_in, status - 1,SEEK_CUR);
			terminating = 1;
			status = 0;
		}
	}
}

void termina_p1(){
	close(p_ordinary[1]);
	close(p_priority[1]);
	close(fd_in);
	close(fd_out);
	close(p1p2[0]);	close(p1p2[1]);
	exit(0);
}
void termina_p2(){
	close(p_ordinary[1]);
	close(p_priority[1]);
	close(fd_in);
	close(fd_out);
	close(p1p2[0]);	close(p1p2[1]);
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
