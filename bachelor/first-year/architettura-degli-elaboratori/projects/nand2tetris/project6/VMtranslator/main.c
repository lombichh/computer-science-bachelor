#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "parser.h"
#include "code_writer.h"

void translate(FILE *vmFile, FILE *asmFile) {
    char line[256];

    while(fgets(line, 256, vmFile) != NULL) {
        // remove newline and clean line
        line[strlen(line) - 1] = '\0';
        clean_line(line);

        // parse line
        parse_line(line, asmFile);
    }

    write_end(asmFile);
}

int main(int argc, char *argv[]) {
    // check if the user has provided a folder
    if (argc >= 2) {
    	FILE *vmFile;
    	vmFile = fopen(argv[1], "r");

        // check if filename is valid
        if(vmFile == NULL) {
            printf("Errore in apertura del file da leggere: %s\n", argv[1]);
            exit(1);
        }

        // create asm file
        FILE *asmFile;

        char filename[64];
        strcpy(filename, argv[1]);
        filename[strlen(filename) - 2] = '\0';
        strcat(filename, "asm");
                        
        asmFile = fopen(filename, "w");

        // write to asm file
        write_initialize_sp(asmFile);
        translate(vmFile, asmFile);

        fclose(vmFile);
        fclose(asmFile);
   } else printf("Usage: %s [filename]\n", argv[0]);

    return 0;
}
