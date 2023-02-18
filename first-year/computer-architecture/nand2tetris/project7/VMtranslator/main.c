#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dirent.h>

#include "parser.h"
#include "code_writer.h"
#include "code_writer.h"
#include "string.h"

void translate(FILE *vm_file, FILE *asm_file) {
    // translate every line of vm_file into asm_file
    char line[256];

    while(fgets(line, 256, vm_file) != NULL) {
        // remove newline and clean line
        line[strlen(line) - 1] = '\0';
        clean_line(line);

        // parse line
        parse_line(line, asm_file);
    }
}

void translate_dir(char *path) {
    DIR *dir = opendir(path);

    if (!dir) printf("Accesso alla cartella '%s' fallito.\n", path);
    else {
        // create asm file
        FILE *asm_file;
        // concat strings to create 'path/folder_name.asm'
        int i = strlen(path) - 2;
        while (*(path + i) != '\\' && *(path + i) != '/')
            i--;
        char *asm_filename = malloc(sizeof(char) * (strlen(path) + strlen(path + i) + 4));
        strcat(strcat(strcpy(asm_filename, path), path + i), ".asm");
        
        asm_file = fopen(asm_filename, "w");
        
        free(asm_filename);

        // initialize SP and call Sys.init function
        // at the beginning of the .asm file
        write_initialize_sp(asm_file);
        write_call("Sys.init", "0", asm_file);

        // translate every .vm file in the directory
        struct dirent *child;
        while (child = readdir(dir)) {
            if (end_with(child->d_name, ".vm")) {
                char *vm_filename = malloc(sizeof(char) *
                    (strlen(path) + 1 + strlen(child->d_name)));
                strcat(strcat(strcpy(vm_filename, path), "/"), child->d_name);

                FILE *vm_file;
                vm_file = fopen(vm_filename, "r");
            	free(vm_filename);
                
	            fprintf(asm_file, "// file: %s\n", child->d_name);

	            child->d_name[strlen(child->d_name) - 3] = '\0';
	            change_input_file(child->d_name);
	            translate(vm_file, asm_file);

	            fclose(vm_file);
            }
        }
        write_end(asm_file);

        fclose(asm_file);
    }
}

void translate_file(char *path) {
    // open vm file
    FILE *vm_file;
    vm_file = fopen(path, "r");

    // check if vm file exists
    if(vm_file == NULL) {
        printf("Accesso al file '%s' fallito.\n", path);
        exit(1);
    }

    // create asm file
    FILE *asm_file;

    char *asm_filename = malloc(sizeof(char) * (strlen(path) + 1));
    strcpy(asm_filename, path);
    asm_filename[strlen(asm_filename) - 2] = '\0';
    strcat(asm_filename, "asm");

    asm_file = fopen(asm_filename, "w");

    free(asm_filename);

    // initialize SP and call Sys.init function
    // at the beginning of the .asm file
    write_initialize_sp(asm_file);
    write_call("Sys.init", "0", asm_file);

    // translate .vm file into .asm file
    translate(vm_file, asm_file);
    write_end(asm_file);

    // close files
    fclose(vm_file);
    fclose(asm_file);
}

int main(int argc, char *argv[]) {
    // check if the user has provided a dir/file
    if (argc >= 2) {
        if (is_directory(argv[1])) translate_dir(argv[1]);
        else translate_file(argv[1]);
    } else printf("Usage: %s [directory_name]\n", argv[0]);

    return 0;
}
