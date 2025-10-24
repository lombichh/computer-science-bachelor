#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>
#include <sys/wait.h>


/*
NOTE: il padre non può chiudere il lato di scrittura sulla pipe, perché deve poter comunicare ai figli il conteggio.
Tuttavia, il padre dovrà prima leggere da pipe i messaggi (in numero non noto a priori) mandati dai figli. 
Il classico ciclo di lettura while(read()>0), quindi si bloccherebbe: infatti, anche qualora entrambi i figli chiudessero il lato di scrittura della PIPE, rimarrebbe comunque aperto quello del padre, lasciando quindi la read del padre BLOCCANTE.

Per istruire il padre circa la fine delle comunicazioni da parte dei figli, si utilizza la convenzione di fare scrivere su pipe a ciascun figlio un apposito "pacchetto di terminazione" (ad esempio "!1" per il proc P1 e "!2" per il proc P2).

Successivamente alla scrittura di tale pacchetto, ciascun processo figlio/nipote deve attendere comunicazione circa il risultato dell'elaborazione da parte del padre. Tuttavia, a seconda dell'ordine di esecuzione dei processi, una read sulla pipe potrebbe avere l'effetto di rileggere i pacchetti di terminazione appena scritti.
Si sceglie quindi di sospendere (system call pause()) ogni figlio/nipote in attesa che il padre scriva il risultato della elaborazione su pipe e quindi sblocchi i figli (segnale SIGUSR2).

*/



int unicaPipe [2], p2p0[2];
int pid0,pid1,pid2;
int fd_in,fd_out;
int maiuscules_p1=0, maiuscules_p2=0;
int term_1 = 0, term_2=0;
int sigint_count=0;
int force_read=0;

void handler_terminazione_lettura();

void comunicazione_risultato();
void handler_terminazione_figlio_p1(int signo);
void handler_terminazione_figlio_p2(int signo);
void handler_term(int signo);
void wait_child();
void termina_figlio_p2();
void termina_figlio_p1();

int main(int argc, char** argv){

	pid0 = getpid();

	if (argc!=3) {
		printf("Usage :\n./unicaPipe <fileIn> <fileOut>\n");
		exit(-1);
	}

	if (argv[1][0]!='/'){
		printf("Il primo argomento deve essere un nome assoluto di file\n");
		exit(-2);
	}

	if (argv[2][0] != '/'){
		printf("Il secondo argomento deve essere un nome assoluto di file\n");
		exit(-3);
	}

	if((fd_out=open(argv[2],O_WRONLY|O_CREAT,0777))<0) {
		perror("Error opening file:");
		exit(-1);
	}
	if (pipe(p2p0)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
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
		if(pid2==0) {//Nipote P2
			pid2=getpid();
			char log[100];
			sprintf(log,"P2:%d\n",pid2);
			write(1,log,strlen(log));

			write(p2p0[1],&pid2,sizeof(int));
			close(p2p0[0]); 
			close(p2p0[1]);
		
			signal(SIGINT,handler_term);
			signal(SIGUSR1,handler_terminazione_figlio_p2);
			signal(SIGUSR2,handler_terminazione_lettura);

			if((fd_in=open(argv[1],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}
			int bytesRead, count = 0;
			char c;
			char line [81];
			char maiuscules [81];


			while((bytesRead=read(fd_in,&c,sizeof(char)))>0){
				if (c=='\n'){
					line[count]='\0';
					if (line[count-1] == '-' || force_read==2){
						int i, maiuscule_count = 0;
						for (i=0;i<strlen(line);i++){
							if(line[i]>= 'A' && line[i]<= 'Z'){
								maiuscules[maiuscule_count] = line[i];
								maiuscule_count++;
							}
						}
						maiuscules[maiuscule_count]='\0';
						//Comunicazione al padre
						char message [82];
						sprintf(message,"%s2",maiuscules);
						write(unicaPipe[1],message, strlen(message));
					}
					
					count = 0;
					sleep(1);
				}
				else{
					line[count] = c;
					count++;
				}
			}
			//invio al padre del pacchetto di terminazione lettura
			char message [3];
			sprintf(message,"!2");
			write(unicaPipe[1],message,strlen(message));
			close(unicaPipe[1]);
		
			//attesa di segnale da padre per cominciare a leggere da PIPE (altrimenti il processo potrebbe consumare caratteri scritti da lui o dall'altro figlio
			pause();
		
			//lettura pacchetto di risposta del padre			
			int father_message[2];
			read(unicaPipe[0],father_message,2*sizeof(int));

			if(father_message[1]>=father_message[0]){
				sprintf(log,"Sono il processo %d (P2) e ho realizzato il conteggio %d più alto\n",getpid(),father_message[1]);
				write(fd_out,log,strlen(log));
			}

			//terminazione del figlio
			termina_figlio_p2();
		}
		else{//Figlio P1
			pid1=getpid();
			char log[100];
			sprintf(log,"P1:%d\n",pid1);
			write(1,log,strlen(log));

			signal(SIGINT,handler_term);
			signal(SIGUSR1,handler_terminazione_figlio_p1);
			signal(SIGUSR2,handler_terminazione_lettura);

			close(p2p0[0]); 
			close(p2p0[1]);

			if((fd_in=open(argv[1],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}
			int bytesRead, count = 0;
			char c;
			char line [81];
			char maiuscules [81];


			while((bytesRead=read(fd_in,&c,sizeof(char)))>0){
				if (c=='\n'){
					line[count]='\0';
					if (line[count-1] == '+'|| force_read==1){
						int i, maiuscule_count = 0;
						for (i=0;i<strlen(line);i++){
							if(line[i]>= 'A' && line[i]<= 'Z'){
								maiuscules[maiuscule_count] = line[i];
								maiuscule_count++;
							}
						}
						maiuscules[maiuscule_count]='\0';
						//Comunicazione al padre
						char message[82];
						sprintf(message,"%s1",maiuscules);
						write(unicaPipe[1],message, strlen(message));	
					}

					count = 0;
					sleep(1);
				}
				else{
					line[count] = c;
					count++;
				}
			}

			//invio al padre del pacchetto di terminazione lettura
			char message [3];
			sprintf(message,"!1");
			write(unicaPipe[1],message,strlen(message));
			close(unicaPipe[1]);
			
			//attesa di segnale da padre per cominciare a leggere da PIPE (altrimenti il processo potrebbe consumare caratteri scritti da lui o dall'altro figlio)
			pause();
	
			//lettura pacchetto di risposta del padre
			int father_message[2];
			read(unicaPipe[0],father_message,2*sizeof(int));

			if(father_message[0]>=father_message[1]){
				sprintf(log,"Sono il processo %d (P1) e ho realizzato il conteggio %d più alto\n",getpid(),father_message[0]);
				write(fd_out,log,strlen(log));
			}
			//terminazione del figlio
			termina_figlio_p1();
		}
		
	}
	else{//Padre P0

		char log[100];
		sprintf(log,"P0:%d\n",pid0);
		write(1,log,strlen(log));

		signal(SIGINT,handler_term);

		int bytesRead, count = 0;
		char message [82] ;
		char c;
		read(p2p0[0],&pid2,sizeof(int));
		close(p2p0[0]); 
		close(p2p0[1]);

		sleep(3);

		while( (term_1 == 0 || term_2 == 0) && (bytesRead=read(unicaPipe[0],&c,sizeof(char)))>0){
			if(c == '2'){
				message[count]='\0';
				if(message[count-1]=='!'){//messaggio di terminazione di P2
					term_2=1;
				}
				else{
					maiuscules_p2 += strlen(message);
					sprintf(log,"Ricevuto da P2 messaggio:%s\n",message);
					write(fd_out,log,strlen(log));
					write(1,log,strlen(log));
				}
				count = 0;
			}
			else if(c == '1'){
				message[count]='\0';
				if(message[count-1]=='!'){//messaggio di terminazione di P1
					term_1=1;
				}
				else{
					maiuscules_p1 += strlen(message);
					sprintf(log,"Ricevuto da P1 messaggio:%s\n",message);
					write(fd_out,log,strlen(log));
					write(1,log,strlen(log));
				}
				count = 0;
			}
			else{
				message[count] = c;
				count++;
			}
			
		}
		comunicazione_risultato();

	}
	

}

void handler_terminazione_figlio_p1(int signo){
	termina_figlio_p1();
}
void handler_terminazione_figlio_p2(int signo){
	termina_figlio_p2();
}

void handler_terminazione_lettura(){
	//non fa nulla, serve solo a gestire il SIGUSR2 che sblocca i processi figli dalla pause
}
void comunicazione_risultato(){
	int messages [4] = {maiuscules_p1,maiuscules_p2,maiuscules_p1,maiuscules_p2};
	write (unicaPipe[1],messages,4*sizeof(int));

	kill(pid1,SIGUSR2);
	kill(pid2,SIGUSR2);

	if(maiuscules_p1 > maiuscules_p2)
		kill(pid2,SIGUSR1);
	else
		kill(pid1,SIGUSR1);
	wait_child();
}

void wait_child() {
	int pid_terminated,status;
	pid_terminated=wait(&status);
	if(WIFEXITED(status))
		printf("\nPADRE %d: terminazione volontaria del figlio %d con stato %d\n",getpid(),pid_terminated,WEXITSTATUS(status));
	else if(WIFSIGNALED(status))
		printf("\nPADRE %d: terminazione involontaria del figlio %d a causa del segnale %d\n",getpid(),pid_terminated,WTERMSIG(status));
}


void termina_figlio_p1(){
	close(unicaPipe[0]);
	close(fd_out);
	close(fd_in);
	wait_child();
	exit(0);
}

void termina_figlio_p2(){
	close(unicaPipe[0]);
	close(fd_out);
	close(fd_in);
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
			force_read = 1;
		}
		else if (pid2 == getpid()){
			termina_figlio_p2();
		}
		else if (pid0 == getpid()){
			term_2=1;
		}
	}
	else if(sigint_count == 2){
		if (pid1 == getpid()){
			termina_figlio_p1();			
		}
		else if (pid2 == getpid()){
			force_read = 2;
		}
		else if (pid0 == getpid()){
			term_1=1;
		}

	}
}
