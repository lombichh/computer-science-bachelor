#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <signal.h>
#define BLOCK 500

//nota: BLOCK identifica la dimensione di un blocco

void handler_term_P2(int sig_no); //gestione del segnale SIGINT (scatenato alla pressione di CTRL+C) per P2
void readBlocks(char sep, int fdIn,int fdOut,int fdPipe, int initFlag); //lettura del file a blocchi

int pipeP1[2],		//pipe utilizzata da P0 e P2 per inviare i conteggi a P1
	fdIn,			//descrittore del file di input
	fdOut;		//descrittore del file di output

main (int argc, char *argv[]) {

	int pid1, pid2, counter=0, status;	//counter tiene traccia del conteggio globale
	char sep;	//carattere separatore

	if (argc!=4) {
		printf("Il programma prevede 3 argomenti\n");
		exit(-1);
	}

	if ((fdIn=open(argv[1],O_RDONLY))<0) {
		printf("Errore nell'apertura del file %s\n", argv[1]);
		exit(-2); 
	}
	if ((fdOut=open(argv[2],O_WRONLY|O_CREAT,0644))<0) {
		printf("Errore nell'apertura/creazione del file %s\n", argv[2]);
		exit(-3);
	}
	//NOTA: 
	//1)	il file di input verrà riaperto da P2 con descrittore separato (P0 e P2 leggono in parallelo discriminando ognuno
	//		i blocchi di propria competenza)
	//2)	il file di output viene scritto con I/O pointer condiviso (P0 e P2 scrivono in condivisione)
	sep = argv[3][0];
	
	pipe(pipeP1);	//apertura della pipe di comunicazione con P1
	signal(SIGINT,SIG_IGN);	//P0 (e P1) devono ignorare SIGINT e proseguire il proprio lavoro
	
	pid1 = fork();	//generazione di P1
	if(pid1 == 0) { 	//codice di P1: creazione di P2
		int value;
		close(fdIn);	//P1 non legge da file, P2 leggerà, ma con I/O pointer separato
		pid2 = fork();	//creazione di P2
		if(pid2 == 0) {
			//codice di P2
			close(pipeP1[0]);				//chiusura del lato di lettura della pipe (P2 scrive)
			fdIn = open(argv[1],O_RDONLY);	//apertura del file di input con I/O pointer separato da quello di P0
			signal(SIGINT,handler_term_P2);	//P2 deve intercettare SIGINT e invocare l'handler di terminazione
			readBlocks(sep, fdIn, fdOut, pipeP1[1], 0);
			//chiusura dei descrittori ancora aperti per P2
			close(pipeP1[1]);
			close(fdIn);
			close(fdOut);
			exit(0);
		}
		else if(pid2<0) {
			perror("Creazione P2:");
			exit(-4);
		}
		else {			//riprende il codice di P1
			close(fdOut);	//P1 non scrive su file
			close(pipeP1[1]);	//chiusura del lato di scrittura della pipe (P1 legge)
			//ciclo di ricezione e accumulo dei conteggi parziali
			//l'uscita dal ciclo avviene quando sia P0 che P2 hanno chiuso il lato di scrittura della pipe
			while (read(pipeP1[0], &value, sizeof(int))) {
				counter = counter + value;	
			}
			wait(&status);//prima di effettuare la stampa, P1 attende il completamento di P2
			printf("Conteggio maiuscole = %d\n",counter);
			//chiusura dei descrittori ancora aperti per P1
			close(pipeP1[0]);				
			exit(0);
		}
	}
	else if(pid1 < 0) {
		perror("Creazione P1:");
		exit(-5);
	}
	else {
		//riprende il codice di P0
		readBlocks(sep, fdIn, fdOut, pipeP1[1], 1);
		//chiusura dei descrittori ancora aperti per P0
		close(pipeP1[1]);
		close(fdIn);
		close(fdOut);
		//attesa della terminazione di P1
		wait(&status);
		exit(0);
	}
}


//lettura del file di input, per P0 e P2
//poiché P0 deve considerare i blocchi dispari e P2 i blocchi pari, initFlag permette di decidere quale dei due
//comportamenti adottare 
void readBlocks(char sep, int fdIn,int fdOut,int fdPipe, int initFlag) {
	int upper = 0, i = 0;
	int flag = initFlag;
	char c;
	
	while(read(fdIn,&c,1)) {
		i++;
		//se il blocco è di propria competenza (flag true) e la lettera letta maiuscola, il conteggio parziale viene
		//incrementato e la lettera scritta sul file di output
		if(flag && c >= 'A' && c <= 'Z') {
			upper++;
			write(fdOut,&c,1);
		}
		//quando si incontra la terminazione di un blocco (ovvero si incontra il separatore o si raggiunge il limite numerico):
		//-si azzerano i contatori
		//-se il blocco appena terminato era di propria competenza, si spedisce il conteggio parziale
		//-si inverte il flag (blocchi alternati)
		else if(c == sep || i == BLOCK) {
			if(flag) {
				write(pipeP1[1],&upper,sizeof(int));
			}
			flag = !flag;
			i = 0;
			upper = 0;
		}
	}
}

//handler per P2
//chiude tutti i descrittori e fa terminare il processo
void handler_term_P2(int sig_no) {
	printf("CTRL+C su P2!");
	close(pipeP1[1]);
	close(fdIn);
	close(fdOut);
	exit(0);
}

