#include <stdlib.h>
#include <string.h>

#include "string.h"

int is_directory(char *path) {
    int is_directory = 0;
    int is_file = 0;

    // check if the first char from the end of the path
    // is a / (directory) or a . (file)
    int i = strlen(path) - 2;
    while (i > 0 && !is_directory && !is_file) {
        char current_char = *(path + i);
        if (current_char == '\\' || current_char == '/') is_directory = 1;
        else if (current_char == '.') is_file = 1;
        i--;
    }

    return is_directory;
}

int end_with(char *str1, char *str2) {
    int end_with = 1;

    int str1_last_index = strlen(str1) - 1;
    int str2_last_index = strlen(str2) - 1;
    int i = 0;
    while (i < strlen(str2) && end_with) {
        if (str1[str1_last_index - i] != str2[str2_last_index - i])
            end_with = 0;
        else i++;
    }
    
    return end_with;
}