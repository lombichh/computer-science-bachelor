#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "assembler.h"
#include "parser.h"
#include "symbolTable.h"


//data è il *numero* corrispondente alla codifica binaria a 16 bit
void output(FILE *f, unsigned short data) {
    char temp[18];
	
	//per stampare in "binario", facciamo & bit a bit
	//se il risultato è 1 scriviamo '1', altrimenti '0'

	int j;
        for(j = 0; j < 16; j++) {
	    //shift a destra di 15-j per selezionare prima il bit più significativo
	    //poi i 2 bit più significativi, poi i 3, etc. Calcolando "... & 1", 
	    //controlliamo se il j-esimo bit (dal *più* significativo) sia 1 o 0:
	    //corrisponde a calcolare data[0]&1, data[0..1]&01, data[0..2]&001, ...
            temp[j] = (data >> (15-j)) & 1 ? '1' : '0';
        }

	temp[16] = '\n';
        temp[17] = '\0';

        printf("in binario: %s", temp);
        fprintf(f, "%s", temp);
    
}


//legge il file, traduce, ed invoca output
void assemble(FILE *asmfile, FILE *hackfile) {
    char buf[256]; //max 256 chars per riga dal file
    
    symbolTable st;

	//aggiunge i simboli predefiniti alla symbol table
	printf("- Simboli predefiniti:\n");
    initDefault(&st);

    //prima passata: inserisce le etichette nella symbol table
	printf("- Prima passata:\n");
    while(fgets(buf, 256 , asmfile) != NULL) {
		rimuoviNewLine(buf);
		printf("Riga letta: %s\n", buf);

		parseSymbols(buf, &st);
    }
 
    //riposiziona il puntatore all'inizio del file
    rewind(asmfile);

    //seconda passata: inserisce le variabili nella
	// symbol table e codifica le A e C instruction
	printf("- Seconda passata:\n");
    while(fgets(buf, 256 , asmfile)!=NULL) {
		rimuoviNewLine(buf);
		pulisciRiga(buf);
		printf("Riga letta: %s\n", buf);
		
		replaceSymbols(buf, &st);

		instruction* op;
		op = parseInstruction(buf, &st);

		if (op != NULL) {
			unsigned short data;

			if (op -> type == A) {
				data = op -> valore;
			} else {

				//invece di prendere le codifiche in binario di dest,comp,jump
				//e concatenarle come stringhe (facendo attenzione che 
				//ciascuna abbia la lunghezza giusta), usiamo shift.

				//formato C-instuctions: 111 a c1-c6 d1-d3 j1-j3
				//quindi 7 shiftato di 13 + comp shiftato di 6 + ...
				
				//TODO
				data = (7 << 13) + ((op -> comp) << 6);
				if (op -> dest != MISSING) data += ((op -> dest) << 3);
				if (op -> jump != MISSING) data += op -> jump;
			}

			printf("numero: %u\n", data);

			output(hackfile, data);
			free(op);
		}
    }
}




