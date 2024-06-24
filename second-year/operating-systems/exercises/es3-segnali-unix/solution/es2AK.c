#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <math.h>
#include <time.h>


// sintassi: segnali T

int T, pid1, pid2;
int figli_terminati=0;
    
void print_usage(char* prog_name){
    fprintf(stderr, "Usage:\n\t%s T\n", prog_name);
}


void P2_handler(int signo){
    int pid3,p_term,status;
    if (signo==SIGUSR2){
        printf("P2 (PID=%d): ricevuto SIGUSR2. Creo il nipote che lancia il comando <date>\n", getpid());
        pid3=fork();
        if (pid3==0){ //P3
            execlp("date","date", (char *)0);
            perror("P3: Exec fallita.");
            exit(EXIT_FAILURE);
        }else if (pid3>0){
            p_term=wait(&status);
            if ((char)status==0) {
                printf("P2 (PID=%d): figlio con PID=%d terminato volontariamente con stato %d.\n", getpid(),p_term, status>>8);
                if ((status>>8)==0)
                    printf("P2 (PID=%d): La data è stata correttamete stampata.\n", getpid());
            }else 
                printf("P2 (PID=%d): figlio con PID=%d terminato involontariamente per segnale %d\n", getpid(),p_term,(char)status);
            exit(0); 
            /*
            * NB: 
            * questa exit(0) è importante. Che cosa succede se la togliamo?
            * Il processo P2 non termina dopo l'esecuzione dell'handler e il lancio di P3, ma va avanti.
            * Torna ad eseguire quel che stava facendo prima dell'arrivo del segnale. 
            * Se P2 era già arrivato alla pause(), tutto ok.
            * Se non aveva ancora eseguito la pause(), P2 la esegue e attende all'infinito un segnale che non arriverà mai
            */
        }else{
            fprintf(stderr, "Errore nella terza fork()\n");
            exit(EXIT_FAILURE);
        }
    }else{
        perror("P2: Ricezione di segnale imprevisto");
        exit(EXIT_FAILURE);
    }
}



void P0_handler(int signo){
    if (signo==SIGUSR1){
        printf("P0 (PID=%d): ricevuto SIGUSR1. Finito!\n", getpid());
        kill(pid1,SIGKILL);
        kill(pid2,SIGKILL);
        exit(0);
    }else if (signo==SIGUSR2){
        printf("P0 (PID=%d): ricevuto SIGUSR2. Inoltro il segnale a P2!\n", getpid());
        kill(pid2,SIGUSR2);
        exit(0);
    }else if (signo==SIGCHLD){
        figli_terminati++;
        printf("P0 (PID=%d): ricevuto SIGCHLD - figli terminati = %d.\n",getpid(), figli_terminati);
        if (figli_terminati==2){
            printf("P0 (PID=%d): Tutti i figli sono terminati!\n",getpid());    
            exit(0);
        }
    }else if (signo==SIGALRM){
        printf("P0 (PID=%d): ricevuto SIGALRM. Timeout scaduto!\n", getpid());
        kill(pid1,SIGKILL);
        kill(pid2,SIGKILL);
        exit(0);
    }else{
        perror("P0: Ricezione di segnale imprevisto");
        exit(EXIT_FAILURE);
    }
}


int main(int argc, char* argv[]){
    
    /*
     * Controllo argomenti    
     */
    if (argc != 2) {
        fprintf(stderr, "Errore nel numero di argomenti\n");
        print_usage(argv[0]);
        exit(EXIT_FAILURE);
    }
    T = atoi(argv[1]);
    if (T<0){
        fprintf(stderr, "Il parametro T deve essere un intero positivo\n");
        exit(EXIT_FAILURE);
    }
    
    //impostazione trattamento segnali (verrà ereditata dai figli)
    signal(SIGUSR1, P0_handler);
    signal(SIGUSR2, P0_handler);
    signal(SIGALRM, P0_handler);
    signal(SIGCHLD, P0_handler);
    
    alarm(T);
     // creazione P1
    pid1 = fork();
    if (pid1==0){ //P1
        //reimposto l'azione di default per i segnali che il figlio non deve gestire
        signal(SIGUSR1, SIG_DFL);
        signal(SIGUSR2, SIG_DFL);
        signal(SIGALRM, SIG_DFL); 
        signal(SIGCHLD, SIG_DFL);
        sleep(3);
        srand(time(NULL));
        int dado=rand()%2; // compreso tra 0 e 1

        if (dado==0){
            printf("P1 (PID=%d): La moneta ha dato esito %d. Invio SIGUSR1 a P0\n",getpid(),dado);
            kill(getppid(), SIGUSR1);
        }else{
            printf("P1 (PID=%d): La moneta ha dato esito %d. Invio SIGUSR2 a P0\n",getpid(),dado);
            kill(getppid(), SIGUSR2);
        }
        exit(0);


    }else if (pid1>0){ 
        // creazione P2
        pid2 = fork();
        if (pid2==0){ //P2
            //P2:
            signal(SIGUSR2, P2_handler);
            //reimposto l'azione di default per i segnali che il figlio non deve gestire
            signal(SIGUSR1, SIG_DFL);
            signal(SIGALRM, SIG_DFL); 
            signal(SIGCHLD, SIG_DFL);
            
            pause(); //P2 attende indefinitamente l'arrivo di un segnale
            exit(0);

        }else if (pid2>0){ 
            //P0:
            for(int i=0;;i++){
                sleep(1);
                printf("P0 (PID=%d): attendo un segnale da %d secondi\n", getpid(), i);
            }

        }else{
            fprintf(stderr, "Errore nella seconda fork()\n");
            exit(EXIT_FAILURE);
        }

    }else{
        fprintf(stderr, "Errore nella prima fork()\n");
        exit(EXIT_FAILURE);
    }
}
