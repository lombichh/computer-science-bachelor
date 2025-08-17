// clean the line from initial/final spaces and comments
void clean_line(char line[]);

// parse line and write to asm file
void parse_line(char line[], FILE *asmFile);