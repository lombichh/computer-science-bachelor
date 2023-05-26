#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "parser.h"
#include "symbolTable.h"

// I valori sono numerici: in assembler.c (funzione output) tradurremo in "binario"

tabella compTable = {
    28, {
        {"0", 42}, //0101010
        {"1", 63}, //0111111
        {"-1", 58}, //0111010
        {"D", 12}, //0001100
        {"A", 48}, //0110000
        {"!D", 13}, //0001101
        {"!A", 49}, //0110001
        {"-D", 15}, //0001111
        {"-A", 51}, //0110011
        {"D+1", 31}, //0011111
        {"A+1", 55}, //0110111
        {"D-1", 14}, //0001110
        {"A-1", 50}, //0110010
        {"D+A", 2}, //0000010
        {"D-A", 19}, //0010011
        {"A-D", 7}, //0000111
        {"D&A", 0}, //0000000
        {"D|A", 21}, //0010101
        {"M", 112}, //1110000
        {"!M", 113}, //1110001
        {"-M", 115}, //1110011
        {"M+1", 119}, //1110111
        {"M-1", 114}, //1110010
        {"D+M", 66}, //1000010
        {"D-M", 83}, //1010011
        {"M-D", 71}, //1000111
        {"D&M", 64}, //1000000
        {"D|M", 85}, //1010101
    }
};

tabella jumpTable = {
    7, {
        {"JGT", 1},
        {"JEQ", 2},
        {"JGE", 3},
        {"JLT", 4},
        {"JNE", 5},
        {"JLE", 6},
        {"JMP", 7}
    }
};

tabella destTable = {
    7, {
        {"M", 1},
        {"D", 2},
        {"MD", 3},
        {"A", 4},
        {"AM", 5},
        {"AD", 6},
        {"AMD", 7},
    }
};

instruction *parseInstruction(char *riga, symbolTable *st) {
    riga = pulisciRiga(riga);
    
    if (strlen(riga) == 0) return NULL;

    if (riga[0] == '(') return NULL;

    if (riga[0] == '@') { //è una A-instruction
        //creare l'istruzione di tipo A
        instruction *instr = (instruction *) malloc(sizeof(instruction));
        instr -> type = A;

        if (riga[1] <= '9' && riga[1] >= '0') {
            //prendere l'indirizzo
            unsigned short instrValue;
            sscanf(riga, "@%hi", &instrValue);
            //testare il range: se maggiore di 15 bit, shiftare
            while (instrValue >> 15 > 0) {
                instrValue = instrValue >> 15;
            }
            instr -> valore = instrValue;
        } else {
            //variabile
            unsigned short symbolValue = findBySymbol(riga + 1, st);
            instr -> valore = symbolValue;
        }

        return instr;
    } else { //è una C-instruction

        //prendere i giusti valori numerici delle 3 componenti della
        //C-instruction dalle tabelle tramite la funzione parseC
        unsigned short comp, dest, jump;

        instruction *instr = (instruction *) malloc(sizeof(instruction));
        instr -> type = C;

        parseC(riga, &comp, &dest, &jump);
        instr -> comp = comp;
        instr -> dest = dest;
        instr -> jump = jump;

        return instr;
    }

    //dummy, solo per compilare (questa è una funzione non-void)
    abort();

}

//fa il parsing della C-instruction ed assegna i valori alle 3 componenti
void parseC(char *riga, unsigned short *comp, unsigned short *dest, unsigned short *jump) {
	*dest = 0;
    *jump = 0;

	//strchr ritorna un puntatore alla prima occorrenza del carattere
    char *compSubString = strchr(riga, '=');
    char *jumpSubString = strchr(riga, ';');

    if (jumpSubString != NULL) {
        //esiste jump
        jumpSubString[0] = '\0'; //ora riga termina prima del ';' cioè è dest=comp
        jumpSubString++;

        rimuoviSpazi(jumpSubString);

        // jumpSubString punta solo alla direttiva di jump (JEQ, JMP...)
        // la cerchiamo nella tabella (giusta) e ritorniamo la codifica 
        // cioè un unsigned char (8 bit, anche se basterebbero 6+1).

        *jump = traduciInBinario(jumpSubString, &jumpTable);
    } else{
        *jump = MISSING;
    }

    if (compSubString != NULL) {
        //esiste dest
        compSubString[0] = '\0'; //ora riga termina prima del '=' cioè è dest
        rimuoviSpazi(riga);
        *dest = traduciInBinario(riga, &destTable);

        compSubString++;
    } else {
        *dest = MISSING;
        compSubString = riga;
    }

    rimuoviSpazi(compSubString);
    *comp = traduciInBinario(compSubString, &compTable);
}

int isInstruction(char *riga) {
    //ritorniamo 1 se la riga è una instruction, altrimenti 0.
    return (riga[0] != '\0' && riga[0] != '/' && riga[0] != '(');
}



//traduce, semplicemente cercando nelle tabelle
unsigned char traduciInBinario(char *chiave, tabella *tabella) {
    int i;
    for(i = 0; i < tabella -> lunghezza; i++) {
        if(strcmp(chiave, tabella -> righe[i].chiave) == 0) {
            return tabella -> righe[i].valore;
        }
    }

    return MISSING;
}


char *pulisciRiga(char *riga) {
    rimuoviSpazi(riga);
    char *commento = strstr(riga, "//");
    if(commento != NULL) {
        *commento = '\0'; //nota: così terminiamo la stringa
        rimuoviSpazi(riga); //in caso ci fossero spazi prima del commento
    }

    return riga;
}



//già visto a lezione (esercizio sulla polish notation)
void rimuoviSpazi(char *str) {
	int i = 0;
    int j = 0;
    while (i < strlen(str)) {
        if (str[i] != ' ') {
            str[j] = str[i];
            j++;
        }
        i++;
    }
    str[j] = '\0';
}

void rimuoviNewLine(char *str){

	//se l'ultimo carattere è un newline lo togliamo (terminando la stringa)
	if(str[strlen(str) - 1] == '\n')
	        str[strlen(str) - 1] = '\0';

	//in realtà sarebbe meglio fare: str[strcspn(str,"\r\n")] = '\0';

}
