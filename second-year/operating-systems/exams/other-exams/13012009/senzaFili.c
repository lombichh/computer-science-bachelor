#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <signal.h>
#include <string.h>
#include <sys/wait.h>


/*
					===================
					NOTE alla soluzione
					===================

==============================
IO Pointer e apertura del file
==============================
Il padre P0 ed i figli P1 e P2 accedono allo stesso file fileIn, P0 in lettura/scrittura, P1 e P2 solo in scrittura. 
Dati i vincoli sulla non sovrapposizione nella scrittura delle righe, viene naturale pensare che P0, P1 e P2 condividano l'IO Pointer in scrittura.
Inoltre, poiché P0 oltre che scrivere su fileIn deve poter leggere, sarà necessario che P0 utilizzi un secondo IO Pointer per la lettura.


===============================
Protocollo di scrittura su PIPE
===============================
Ciascun processo scrive su pipe un pacchetto stringa del tipo:

[ id_proc, line_count_mod_3, len, row ]

dove:
*) id_proc è uno tra i caratteri 0, 1 o 2 e rappresenta il processo che ha inviato il pacchetto
*) line_count_mod_3 è il carattere che rappresenta l'intero (0, 1 o 2) resto della divisione del numero di riga per 3 (perché ciascun processo possa decidere se la scrittura su fileIn della riga è di sua competenza o meno)
*) len è una coppia di caratteri rappresentante la lunghezza della riga scritta su pipe (se la riga è lunga meno di 10 caratteri, len sarà del tipo "0x" (es. 03 per una riga di 3 caratteri) )
*) row: contenuto della riga 

Note al protocollo: la lettura da pipe può essere effettuata tramite due read: la prima legge l'header e determina la lunghezza del "payload" (row), la seconda legge appunto row.
In questa situazione, avere una lettura non atomica del pacchetto (2 read) in realtà non crea problemi di sincronizzazione poiché per ogni pipe esiste uno ed un solo processo che leggerà da quella pipe. Al contrario, la scrittura DEVE essere atomica (1 sola write) perché almeno due processi possono scrivere su ciascuna pipe.
Si segnala infine che l'header utilizzato risulta comodo per poter discriminare il processo mittente (due processi possono scrivere su ciascuna pipe) e per comunicare informazioni circa la posizione della riga nel testo (line_count_mod_3). Il solo problema della lettura da pipe di una riga di lunghezza non nota a priori si sarebbe potuto risolvere seplicemente leggendo carattere per carattere da pipe fino al carattere '\n'.

============================================
Gestione bidirezionalità a seguito di CTRL-C
============================================
Comunicazione tra processi mediante 3 pipe; per ogni pipe 
*) 1 processo lettore
*) 2 (possibili) processi scrittori

Il pacchetto di volta in volta scritto (in maniera atomica da ciascuno scrittore) reca l'indicazione della provenienza e quindi è possibile capire verso quale processo inviare il risultato dell'elaborazione del pacchetto.

Questa soluzione presenta un potenziale problema in fase di terminazione dei processi: poiché per ciascuna pipe il lato di scrittura è aperto sia dal padre che da uno dei figli, il ciclo di lettura del processo figlio "destinatario" rischia di bloccarsi sulla read indefinitamente. Infatti, il padre potrebbe chiudere il lato di scrittura al termine della lettura del file, ma questo non è vero per l'altro processo figlio (anch'esso verosimilmente impegnato in un ciclo di lettura). 
Per ovviare a questo problema, il padre potrebbe inviare un segnale di terminazione ai due processi (da gestire opportunamente), oppure, più semplicemente, inviare nel telefono senza fili un pacchetto di "termine delle comunicazioni" (ad esempio, un pacchetto costituito dai 4 caratteri "3000"), ovviamente al figlio "destinatario" del verso corrente (P1 per il verso normale, P2 per il verso contrario). 
Il processo reagisce alla lettura di questo pacchetto inviandone uno analogo (ad es. "4000") all'altro figlio e chiudendo subito dopo il relativo lato di scrittura della pipe.
Che problema avremmo utilizzando lo stesso pacchetto, "forwardato" dal primo al 2° figlio?
Che problema avremmo se fosse il padre ad inviare lo stesso pacchetto non ad uno ma ad entrambi i figli?



*/


int fd_in_write, fd_in_read;
int pid0,pid1,pid2 = 0;
int toP1 [2], toP2[2], toP0 [2];
char car1,car2,car3;
int diretto = 0;
char term_packet [5]="3000\0";
char forwarded_term_packet [5]="4000\0";

void scriviPacchetto (char* pacchetto, int pipe []);
void preparaPacchetto (char line_wo_char [], char packet [], char proc, int mod3);
void rimuoviCarattere (char stringaIn [], char stringaOut [],char car);
void termine_padre();
void termina_p1();
void termina_p2();
void wait_child();
void handler_inversione();

int main(int argc, char** argv){

	pid0 = getpid();

	if (argc!=5) {
		printf("Usage :\n./senzaFili <car1> <car2> <car3> <fileIn>\n");
		exit(-1);
	}
	if (argv[4][0]!='/'){
		printf("Il secondo argomento deve essere un nome assoluto di file\n");
		exit(-2);
	}

	if (strlen(argv[1])!=1){
		printf("Il primo argomento deve essere un carattere\n");
		exit(-2);

	}

	if (strlen(argv[2])!=1){
		printf("Il secondo argomento deve essere un carattere\n");
		exit(-2);

	}

	if (strlen(argv[3])!=1){
		printf("Il terzo argomento deve essere un carattere\n");
		exit(-2);

	}
	car1 = argv[1][0];
	car2 = argv[2][0];
	car3 = argv[3][0];

	if((fd_in_write=open(argv[4],O_WRONLY))<0) {
		perror("Error opening file:");
		exit(-1);
	}

	if (pipe(toP1)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	}
	if (pipe(toP2)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	}
	if (pipe(toP0)<0){
		printf("Errore nella creazione della pipe\n");
		exit(-4);
	}

	if((pid1=fork())<0) {
		perror("Errore nella fork:");
		exit(-5);
	}
	
	if(pid1==0) {//Figlio P1

			signal(SIGINT,SIG_IGN);

			pid1=getpid();
			close(toP0[0]);
			close(toP1[1]);
			close(toP2[0]);
			
			char header[4];
			char body[81];
			int bytesRead;
			char line_wo_char [81];
			char pacchetto [85];
			char log [100];
			

			while((bytesRead=read(toP1[0],header,4*sizeof(char)))>0){
				
				char proc = header[0];
				char str [2];
				sprintf(str,"%c",header[1]);
				int mod3 = atoi(str);				
				int size = 0;

				if (proc=='3'){//ricevuto pacchetto di terminazione

					write(toP2[1],forwarded_term_packet,strlen(term_packet));

					close (toP2[1]); close (toP0[1]);
					continue;
				}
				if (proc=='4'){//ricevuto pacchetto di terminazione "forwardato"

					close (toP2[1]); close (toP0[1]);
					continue;
				}


				if (header[2]== '0'){
					sprintf(str,"%c",header[3]);
					size = atoi(str);
				}
				else{
					char length[3];
					length[0]=header[2];
					length[1]=header[3];
					length[2]='\0';
					size = atoi(length);
				}
			
				read(toP1[0],body,size*sizeof(char));
				body[size]='\0';
				rimuoviCarattere (body, line_wo_char,car2);

				if (mod3 == 1){
					write(fd_in_write, line_wo_char, strlen(line_wo_char));
					sprintf(log,"Processo %d scrive su file: %s",getpid(),line_wo_char);
					write(1,log,strlen(log));
				}
				preparaPacchetto (line_wo_char,pacchetto,'1',mod3);

				if (proc == '0') //pacchetto in flusso normale
					scriviPacchetto (pacchetto, toP2);
				else //pacchetto in flusso inverso
					scriviPacchetto (pacchetto, toP0);


				sleep(1);

			}
			termina_p1();

	
	}//Fine Figlio P1
	else{
		if((pid2=fork())<0) {
			perror("Errore nella fork:");
			exit(-5);
		}
		if(pid2==0) {//Figlio P2
			
			signal(SIGINT,SIG_IGN);

			pid2=getpid();
			close(toP0[0]);
			close(toP1[0]);
			close(toP2[1]);
			char header[4];
			char body[81];
			int bytesRead;
			char line_wo_char [81];
			char pacchetto [85];
			char log[100];

			while((bytesRead=read(toP2[0],header,4*sizeof(char)))>0){

				char proc = header[0];
				char str [2];
				sprintf(str,"%c",header[1]);
				int mod3 = atoi(str);				
				int size = 0;
				
				if (proc=='3'){//ricevuto pacchetto di terminazione

					write(toP1[1],forwarded_term_packet,strlen(term_packet));

					close (toP1[1]); close (toP0[1]);
					continue;
				}
				if (proc=='4'){//ricevuto pacchetto di terminazione "forwardato"

					close (toP1[1]); close (toP0[1]);
					continue;
				}


				if (header[2]== '0'){
					sprintf(str,"%c",header[3]);
					size = atoi(str);
				}
				else{
					char length[3];
					length[0]=header[2];
					length[1]=header[3];
					length[2]='\0';
					size = atoi(length);
				}

				read(toP2[0],body,size*sizeof(char));
				body[size]='\0';
				rimuoviCarattere (body, line_wo_char,car3);
				
				if (mod3 == 2){
					write(fd_in_write, line_wo_char, strlen(line_wo_char));
					sprintf(log,"Processo %d scrive su file: %s",getpid(),line_wo_char);
					write(1,log,strlen(log));
				}
				preparaPacchetto (line_wo_char,pacchetto,'2',mod3);

				if (proc == '1') //pacchetto in flusso normale
					scriviPacchetto (pacchetto, toP0);
				else //pacchetto in flusso inverso
					scriviPacchetto (pacchetto, toP1);

				sleep(1);
			}
			termina_p2();

		}//Fine Figlio P2 (if)
		else{//Padre
			close(toP0[1]);
			close(toP1[0]);
			close(toP2[0]);
			
			signal(SIGINT,handler_inversione);

			if((fd_in_read=open(argv[4],O_RDONLY))<0) {
				perror("Error opening file:");
				exit(-1);
			}

			int bytesRead = 0, count = 0;
			char c;
			char line [81];
			char line_wo_char [81];
			char pacchetto [85];
			int line_count = 0;
			char log[100];
			while((bytesRead=read(fd_in_read,&c,sizeof(char)))>0){
				if (c == '\n'){
					line_count++;
					line [count] = c;
					line [count+1] = '\0';
					rimuoviCarattere(line,line_wo_char,car1);
					if (line_count % 3 == 0){
						write(fd_in_write, line_wo_char, strlen(line_wo_char));
						sprintf(log,"Processo %d scrive su file: %s",getpid(),line_wo_char);
						write(1,log,strlen(log));
					}
					preparaPacchetto (line_wo_char,pacchetto,'0',line_count % 3);
					if (diretto == 0)
						scriviPacchetto (pacchetto, toP1);
					else
						scriviPacchetto (pacchetto, toP2);
					count = 0;
					sleep(1);
				}
				else{
					line [count] = c;
					count++;
				}

			}

			//disabilito la gestione dell'inversione: a questo punto tutti i pacchetti sono già stati inseriti 
			//in un verso oppure nell'altro e vanno gestiti secondo il flusso di lavoro prestabilito
			signal(SIGINT,SIG_DFL);

			if (diretto == 0)
				scriviPacchetto (term_packet, toP1);
			else
				scriviPacchetto (term_packet, toP2);

			while((bytesRead=read(toP0[0],&c,sizeof(char)))>0){} //consumo i byte scritti su pipe  toP0 dai figli

			termine_padre();
		}
	}

}
void scriviPacchetto (char* pacchetto, int pipe [2]){
	write(pipe[1],pacchetto,strlen(pacchetto));
}

void preparaPacchetto (char line_wo_char[], char packet[], char proc, int mod3){

	if (strlen(line_wo_char) < 10)
		sprintf(packet,"%c%d0%d%s",proc,mod3, strlen(line_wo_char),line_wo_char);
	else
		sprintf(packet,"%c%d%d%s",proc,mod3, strlen(line_wo_char),line_wo_char);
}

void rimuoviCarattere (char stringaIn [], char stringaOut [],char car){
	int i=0, resultIndex=0;
	while (stringaIn[i] != '\0'){
		if (stringaIn[i] != car){
			stringaOut[resultIndex] = stringaIn[i];
			resultIndex++;
		}
		i++;
	}
	stringaOut[resultIndex] = '\0';
}

void handler_inversione(){
	diretto = 1;
}

void termina_p1(){
	close (fd_in_write);
	close(toP0[1]);
	close(toP1[0]);
	exit(0);
}

void termina_p2(){
	close (fd_in_write);
	close(toP0[1]);
	close(toP2[0]);
	exit(0);
}

void termine_padre(){


	close(fd_in_read);
	close(fd_in_write);
	close(toP0[0]);
	close(toP1[1]);
	close(toP2[1]);
	wait_child();
	wait_child();
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
