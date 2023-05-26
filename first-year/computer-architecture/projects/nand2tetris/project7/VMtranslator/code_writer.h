void change_input_file(char input_file[]);

void write_initialize_sp(FILE *asm_file);

void write_push(char *segment, char *num, FILE *asm_file);
void write_pop(char *segment, char *num, FILE *asm_file);

void write_add(FILE *asm_file);
void write_sub(FILE *asm_file);
void write_neg(FILE *asm_file);
void write_eq(FILE *asm_file);
void write_gt(FILE *asm_file);
void write_lt(FILE *asm_file);
void write_and(FILE *asm_file);
void write_or(FILE *asm_file);
void write_not(FILE *asm_file);

void write_label(char *label_name, FILE *asm_file);
void write_goto(char *label_name, FILE *asm_file);
void write_ifGoto(char *label_name, FILE *asm_file);

void write_function(char *function_name, char *local_vars_num, FILE *asm_file);
void write_call(char *function_name, char *args_num, FILE *asm_file);
void write_return(FILE *asm_file);

void write_end(FILE *asm_file);