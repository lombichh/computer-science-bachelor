#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>
#include <sys/wait.h>


void wait_child();
void termina_p0();
void termina_p1();
void termina_p2();
void termina_p3();
void handler_term(int signum);
void leggiELoggaMessaggio();
void handler_leggiMessaggio(int signum);

int pid0,pid1,pid2,pid3, num, force_read = 0;
int unicaPipe [2];
int fd_in,fd_out;
int sigint_count = 0;
char msg [2];


/*

Soluzione di sincronizzazione proposta (una fra le possibili):
I processi figli P2 e P3 scrivono su pipe condivisa un "pacchetto" dati composto da 
 - un intero (2 o 3) per individuare il processo mittente (risp. P2 e P3)
 - una coppia di caratteri ("sì" oppure "no"), come da richieste

Il coordinamento dei processi lettori avviene mediante segnalazione: 
un processo legge l'intero che identifica il mittente:
	- se di propria pertinenza --> legge anche il messaggio (i due caratteri successivi nella pipe)
	- se NON di propria pertinenza --> segnala all'altro processo di leggere il messaggio

*/

int main(int argc, char** argv){

	pid0 = getpid();
	signal(SIGINT,handler_term);


	if (argc!=4) {
		printf("Usage :\n./soluzioneB <num> <fileIn> <fileOut>\n");
		exit(-1);
	}

	if (argv[3][0]!='/'){
		printf("Il terzo argomento deve essere un nome assoluto di file\n");
		exit(-2);
	}

	if (argv[2][0] == '/'){
		printf("Il secondo argomento deve essere un nome relativo di file esistente\n");
		exit(-2);
	}
	int i;
	for(i=0;i<strlen(argv[1]);i++){
		if(argv[1][i]<'0' || argv[1][i]>'9'){
			printf("Il primo argomento deve essere un numero\n");
			exit(-2);
		}
	}		
	num=atoi(argv[1]);

	if((fd_out=open(argv[3],O_WRONLY|O_CREAT,0777))<0) {
		perror("Error opening file:");
		exit(-1);
	}

	if (pipe(unicaPipe)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	}

	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {
		if((pid2=fork())<0) {
			perror("Errore nella fork:");
			exit(-5);
		}
		if(pid2==0) {//Figlio P2
			close(fd_out);
			pid2=getpid();
			if((fd_in=open(argv[2],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}
			int charcount = 0, bytesRead = 0, ignore_line=0, minuscule_count = 0;
			char c;
			int process = 2;
			while((bytesRead=read(fd_in,&c,sizeof(char)))>0){
				charcount++;
				if(charcount == 1 && c != '2'){
					ignore_line = 1;
				}
				if (c == '\n'){
					if (ignore_line == 0){
						//comunicazione
						write (unicaPipe[1],&process,sizeof(int));
						if(minuscule_count > num)
							write (unicaPipe[1],"sì",sizeof(char)*2);
						else
							write (unicaPipe[1],"no",sizeof(char)*2);
						char log[100];
						sprintf(log,"P2: scrittura su pipe\n");
						write(1,log,strlen(log));

					}
					//reset
					charcount = 0; ignore_line=0, minuscule_count = 0;
				}
				else{ //lettura caratteri della riga
					if (ignore_line == 0 && c >= 'a' && c <= 'z'){
						minuscule_count ++;
					}
				}
			}
			termina_p2();
		}//Fine Figlio P2 (if)
		else{
			if((pid3=fork())<0) {
				perror("Errore nella fork:");
				exit(-5);
			}
			if(pid3==0) {//Figlio P3
				close(fd_out);
				pid3=getpid();
				if((fd_in=open(argv[2],O_RDONLY))<0) {
					perror("Error opening file:");
					exit(-1);
				}
				int charcount = 0, bytesRead = 0, ignore_line=0, minuscule_count = 0;
				char c;
				int process = 3;
				while((bytesRead=read(fd_in,&c,sizeof(char)))>0){
					charcount++;
					if(charcount == 1 && c != '3'){
						ignore_line = 1;
					}
					if (c == '\n'){
						if (ignore_line == 0 || force_read == 1){
							//comunicazione
							write (unicaPipe[1],&process,sizeof(int));
							if(minuscule_count > num)
								write (unicaPipe[1],"sì",sizeof(char)*2);
							else
								write (unicaPipe[1],"no",sizeof(char)*2);
							char log[100];
							sprintf(log,"P3: scrittura su pipe\n");
							write(1,log,strlen(log));
							
						}
						//reset
						charcount = 0; ignore_line=0, minuscule_count = 0;
					}
					else{ //lettura caratteri della riga
						if (ignore_line == 0 && c >= 'a' && c <= 'z'){
							minuscule_count ++;
						}
					}
				}
				termina_p3();
			}//Fine Figlio P3 (if)
			else{//Figlio P1
				close(unicaPipe[1]);
				pid1=getpid();
				signal (SIGUSR1,handler_leggiMessaggio);
				sleep(1);
				pause();
				int process, bytesRead;
				char log[100];
				sprintf(log,"P1: inizio ciclo lettura\n");
				write(1,log,strlen(log));

				while((bytesRead=read(unicaPipe[0],&process,sizeof(int)))>0){
					sprintf(log,"P1: letto %d da unicaPipe\n",process);
					write(1,log,strlen(log));

					if (process == 3){
						sprintf(log,"P1: lettura\n");
						write(1,log,strlen(log));

						leggiELoggaMessaggio();
					}
					else{

						sprintf(log,"P1 in attesa\n");
						write(1,log,strlen(log));

						kill (getppid(),SIGUSR1);
						pause();
						sprintf(log,"P1 sbloccato\n");
						write(1,log,strlen(log));

					}
				}
				
				kill (getppid(),SIGUSR1);

				wait_child();
				wait_child();
				termina_p1();
			}//Fine Figlio P1 (else)
		}
	}
	else{ //Padre P0
		close(unicaPipe[1]);
		signal (SIGUSR1,handler_leggiMessaggio);
		char log[100];
		sprintf(log,"Pid0: %d\n",pid0);
		write(1,log,strlen(log));
		sprintf(log,"Pid1: %d\n",pid1);
		write(1,log,strlen(log));
		sprintf(log,"Pid2: %d\n",pid2);
		write(1,log,strlen(log));
		sprintf(log,"Pid3: %d\n",pid3);
		write(1,log,strlen(log));

		sleep(2);

		int process, bytesRead;
		while((bytesRead=read(unicaPipe[0],&process,sizeof(int)))>0){
			sprintf(log,"P0: letto %d da unicaPipe\n",process);
			write(1,log,strlen(log));

			if (process == 2){
				sprintf(log,"P0: lettura\n");
				write(1,log,strlen(log));

				leggiELoggaMessaggio();
			}
			else{

				kill (pid1,SIGUSR1);

				sprintf(log,"P0 in attesa\n");
				write(1,log,strlen(log));
				pause();
				sprintf(log,"P0 sbloccato\n");
				write(1,log,strlen(log));

			}
		}
		//il primo processo lettore che termina il ciclo di lettura, 
		//riutilizza SIGUSR1 per risvegliare l'altro dalla pausa: l'handler tenterà una lettura da una pipe con 		//lato di scrittura chiuso (o che verrà chiuso a breve), restituendo quindi 0.
		kill (pid1,SIGUSR1);
		wait_child();
		termina_p0();
	}

}
void leggiELoggaMessaggio(){
	int bytesread = read(unicaPipe[0],msg,sizeof(char)*2);
	if (bytesread > 0){
		char out [10];
		sprintf(out,"%d:%s\n",getpid(),msg);
		write(fd_out,out,strlen(out));
	}
}

void handler_leggiMessaggio(int signum){
	signal(signum,handler_leggiMessaggio);
	leggiELoggaMessaggio();
}

void termina_p0(){
	close(fd_out);
	close(unicaPipe[0]);
	exit(0);
}

void termina_p1(){
	close(fd_out);
	close(unicaPipe[0]);
	exit(0);
}

void termina_p2(){
	close(fd_in);
	close(unicaPipe[1]);
	exit(0);
}

void termina_p3(){
	close(fd_in);
	close(unicaPipe[1]);
	exit(0);
}




/*
	ATTENZIONE: il presente handler è stato progettato nell'ipotesi semplificativa di gestione reliable dei segnali con 		innestamento.
	Si ricorda che la gestione dei segnali in ambiente Linux al contrario è non-reliable, con blocco del segnale che ha 		scatenato l'handler per tutta l'esecuzione dell'handler e accodamento al più di un segnale.
*/
void handler_term(int signum){

	signal(signum,handler_term);

	sigint_count++;

	if(sigint_count == 1){
		sleep(1);
		
		char out [100];
		sprintf(out,"Proc %d: Sigint count = %d\n",getpid(),sigint_count);
		write(1,out,strlen(out));

		if (pid1 == getpid()){
			return;
		}
		else if (pid1 == getpid()){
			wait_child();
			wait_child();
			termina_p1();
		}
		else if (pid2 == getpid()){
			force_read = 1;			
		}
		else if (pid3 == getpid()){
			termina_p3();
		}
	}
	else if(sigint_count == 2){
		if (pid0 == getpid()){
			wait_child();
			termina_p0();
		}
		else if (pid1 == getpid()){
			wait_child();
			wait_child();
			termina_p1();
		}
		else if (pid2 == getpid()){
			termina_p2();
		}
		else if (pid3 == getpid()){
			termina_p3();
		}


	}

	exit(0);
}



void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
		if(WIFEXITED(status))
			printf("\nPADRE %d: terminazione volontaria del figlio %d con stato %d\n",getpid(), pid_terminated,WEXITSTATUS(status));
		else if(WIFSIGNALED(status))
			printf("\nPADRE %d: terminazione involontaria del figlio %d a causa del segnale %d\n",getpid(), pid_terminated,WTERMSIG(status));
}
