#include <stdio.h>
#include <string.h>
#include "code_writer.h"

void clean_line(char line[]) {
    int i = 0;
    int j = 0;
    int comment = 0;

    // remove initial spaces
    while(line[i] == ' ') i++;

    // remove comments
    while(line[i] != '\0' && line[i] != '\r') {
        if(line[i] == '/' && line[i + 1] == '/') {
            comment = 1;
            break;
        }
        line[j] = line[i];
        i++;
        j++;
    }

    // remove final spaces
    if(!comment) while(line[j - 1] == ' ') j--;

    line[j] = '\0';
}

void split_instruction(char line[], char command[], char arg1[], char arg2[]) {
    int i = 0;
    int j = 0;

    while (line[i] != ' ' && line[i] != '\0') {
        command[j] = line[i];
        i++;
        j++;
    }
    command[j] = '\0';

    while (line[i] == ' ') i++;

    j = 0;
    while (line[i] != ' ' && line[i] != '\0') {
        arg1[j] = line[i];
        i++;
        j++;
    }
    arg1[j] = '\0';

    while (line[i] == ' ') i++;

    j = 0;
    while (line[i] != ' ' && line[i] != '\0') {
        arg2[j] = line[i];
        i++;
        j++;
    }
    arg2[j] = '\0';
}

void parse_line(char line[], FILE *asmFile) {
    int line_length = strlen(line);

    if (line_length != 0) {
        char command[line_length];
        char arg1[line_length];
        char arg2[line_length];

        split_instruction(line, command, arg1, arg2);

        if (strcmp(command, "push") == 0) write_push(arg1, arg2, asmFile);
        else if (strcmp(command, "pop") == 0) write_pop(arg1, arg2, asmFile);
        else if (strcmp(command, "add") == 0) write_add(asmFile);
        else if (strcmp(command, "sub") == 0) write_sub(asmFile);
        else if (strcmp(command, "neg") == 0) write_neg(asmFile);
        else if (strcmp(command, "eq") == 0) write_eq(asmFile);
        else if (strcmp(command, "gt") == 0) write_gt(asmFile);
        else if (strcmp(command, "lt") == 0) write_lt(asmFile);
        else if (strcmp(command, "and") == 0) write_and(asmFile);
        else if (strcmp(command, "or") == 0) write_or(asmFile);
        else if (strcmp(command, "not") == 0) write_not(asmFile);
        else if (strcmp(command, "label") == 0) write_label(arg1, asmFile);
        else if (strcmp(command, "goto") == 0) write_goto(arg1, asmFile);
        else if (strcmp(command, "if-goto") == 0) write_ifGoto(arg1, asmFile);
        else if (strcmp(command, "function") == 0) write_function(arg1, arg2, asmFile);
        else if (strcmp(command, "call") == 0) write_call(arg1, arg2, asmFile);
        else if (strcmp(command, "return") == 0) write_return(asmFile);
    }
}
