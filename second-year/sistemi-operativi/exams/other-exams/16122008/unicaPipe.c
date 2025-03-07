#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>
#include <sys/wait.h>


/*
NOTE alla soluzione

==========================
Pacchetto da figli a padre

[ id_proc, len, pos0, pos1, ... ]
dove
*) id_proc: intero (1,2) che identifica processo P1 o P2
*) len: intero che identifica il numero di posiz passate.
*) pos0, .., posN: interi che rappresentano le posizioni del carattere cercato nella riga analizzata

============================
Sincronizzazione padre-figli

Ciascun figlio, al termine della fase di lettura, 
*)invia un opportuno pacchetto di terminazione (ad esempio costituito da due interi a zero).
*) si mette in pausa (per non interferire nel processo di lettura da pipe del padre)

Il padre scrive su pipe il PID del vincitore e poi usa
*) segnale SIGUSR1 per sbloccare il figlio "vincitore"
*) segnale SIGUSR2 per sbloccare il figlio "perdente"

Il figlio "vincitore" legge da pipe e scrive su file.
Il figlio "perdente" termina immediatamente.

Una soluzione alternativa per la terminazione dei figli (meno aderente al testo ma con l'imppiego di un segnale in meno) da considerarsi ugualmente corretta si può ottenere imponendo la scrittura su pipe da parte del padre di due pacchetti uguali con PID  vincitore; a questo punto entrambi i figli leggono un pacchetto ed il perdente decide in maniera autonoma di terminare (e non più a seguito della ricezione di un segnale opportuno di terminazione). Si noti che è comunque necessario che il padre invii un segnale ai figli per sbloccarli dalla pausa (questa volta però il segnale è lo stesso per i due figli)

*/


int fd_in,fd_out;
int pid0,pid1,pid2 = 0;
int unicapipe [2];
int conta_processi_terminati = 0;
int messaggi_p1 = 0, messaggi_p2 = 0;

int forza_lettura=0;

char carattere_target;
void termine_processo(int signo);
void termine_padre();
void elabora_file(char proc);
void wait_child() ;
void handler_term(int signo);

void handler_forza_lettura(int signo);

int main(int argc, char** argv){

	pid0 = getpid();

	if (argc!=3) {
		printf("Usage :\n./unicapipe <searchCar> <fileIn>\n");
		exit(-1);
	}
	if (argv[2][0]!='/'){
		printf("Il secondo argomento deve essere un nome assoluto di file\n");
		exit(-2);
	}

	carattere_target = argv[1][0];

	if (strlen(argv[1])!=1){
		printf("Il primo argomento deve essere un carattere\n");
		exit(-2);

	}

	if (pipe(unicapipe)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	}
	if((fd_out=open("tmp",O_WRONLY|O_CREAT,0777))<0) {
		perror("Error opening file:");
		exit(-1);
	}


	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {//Figlio P1
			signal(SIGUSR1,termine_processo);
			signal(SIGUSR2,termine_processo);
			signal(SIGINT,handler_forza_lettura);

			pid1=getpid();
			if((fd_in=open(argv[2],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}
			elabora_file('1');
			pause();
	}//Fine Figlio P1
	else{
		if((pid2=fork())<0) {
			perror("Errore nella fork:");
			exit(-5);
		}
		if(pid2==0) {//Figlio P2
			signal(SIGUSR1,termine_processo);
			signal(SIGUSR2,termine_processo);
			signal(SIGINT,termine_processo);

			pid2=getpid();
			if((fd_in=open(argv[2],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}

			elabora_file('2');
			pause();
		}//Fine Figlio P2 (if)
		else{//Padre

			signal(SIGINT,handler_forza_lettura);

			int header[2];
			int body[80];
			int bytesRead;
			sleep(1);
			while((bytesRead=read(unicapipe[0],header,2*sizeof(int)))>0){
				if (header[0] == 0){
					conta_processi_terminati++;
					if (conta_processi_terminati == 2 || ( forza_lettura==1 && conta_processi_terminati == 1) )
						termine_padre();
					else
						continue;
				}
				read(unicapipe[0],body,sizeof(int)*header[1]);
				if (header[0] == 1){
					messaggi_p1++;
				}
				else if (header[0] == 2){
					messaggi_p2++;
				}
				
				//Preparazione versione a caratteri del pacchetto
				char log [300];
				sprintf(log,"Padre: [%d,%d",header[0],header[1]);

				int i;
				for(i=0;i<header[1];i++){
					sprintf(log,"%s,%d",log,body[i]);
				}
				sprintf(log,"%s]\n",log);

				write(1,log,strlen(log));

				write(fd_out,log,strlen(log));
			}
		}
	}

}

void elabora_file(char proc){
	int bytesRead = 0, count = 0;
	char c;
	char line [81];

	while((bytesRead=read(fd_in,&c,sizeof(char)))>0){
		line [count] = c;
		if (c == '\n'){
			line [count+1] = '\0';
			if (line [count-1] == proc || forza_lettura == 1){//elaborazione

				//Nota: la procedura di lettura file è comune ai due processi, 
				//quindi potenzialmente anche per P2 ci potrebbe essere una situazione di lettura forzata (valutazione della condizione if).
				//In realtà, poiché lo spazio di indirizz. dei processi è separato e poiché la variabile forza_lettura 
				//può assumere valore 1 solo a seguito della esecuzione di un handler (handler_forza_lettura) registrato per il solo P1 
				//(e per P0), la lettura forzata potrà avvenire eventualmente solo per P1 (e solo a seguito della pressione di CTRL-C).

				int packet [82]; //i primi due int sono per id processo e num di posizioni trovate 
				int found_positions = 0;
				int i;
				for (i=0;i<count;i++){
					if(line [i] == carattere_target){
						packet[found_positions+2] = i;
						found_positions++;
					}
				}
				if (proc == '1')
					packet [0] = 1;
				else if (proc == '2')
					packet [0] = 2;

				packet [1] = found_positions;

				write(unicapipe[1],packet,sizeof(int)*(2+found_positions));
				sleep(1);
			}
			else{//ignora
			}
			count = 0;
	
		}
		else{
			count++;
		}
	}
	//Scrittura pacchetto che segnala la terminazione della lettura
	int term_packet[2];
	term_packet[0] = 0;
	term_packet[1] = 0;
	write(unicapipe[1],term_packet,2*sizeof(int));
}

void termine_padre(){

	if (messaggi_p1 > messaggi_p2){
		write(unicapipe[1],&pid1,sizeof(int));
		kill(pid1,SIGUSR1);//vittoria
		kill(pid2,SIGUSR2);//terminazione
	}
	else{
		write(unicapipe[1],&pid2,sizeof(int));
		kill(pid2,SIGUSR1);//vittoria
		kill(pid1,SIGUSR2);//terminazione
	}

	close(fd_out);
	wait_child();
	wait_child();
	close(unicapipe[0]);
	close(unicapipe[1]);
	exit(0);
}

void termine_processo(int signo){
	if (signo== SIGUSR1){
		int pid_vincitore=0;
		read(unicapipe[0],&pid_vincitore,sizeof(int));
		if (pid_vincitore == getpid()){
			//scrittura su file
			char log [100];
			sprintf(log,"Sono il processo %d e ho inviato il numero maggiore di messaggi\n",getpid());
			write(fd_out,log,strlen(log));
		}
	}
	close(fd_out);
	close(fd_in);
	close(unicapipe[0]);
	close(unicapipe[1]);
	exit(0);
}

void handler_forza_lettura(int signo){
	forza_lettura=1;
}


void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE: terminazione volontaria del figlio %d con stato %d\n",pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE: terminazione involontaria del figlio %d a causa del segnale %d\n",pid_terminated,WTERMSIG(status));
}
