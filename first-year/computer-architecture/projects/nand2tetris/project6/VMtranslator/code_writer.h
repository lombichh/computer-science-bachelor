void write_initialize_sp(FILE *asmFile);

void write_push(char segment[], char num[], FILE *asmFile);
void write_pop(char segment[], char num[], FILE *asmFile);

void write_add(FILE *asmFile);
void write_sub(FILE *asmFile);
void write_neg(FILE *asmFile);
void write_eq(FILE *asmFile);
void write_gt(FILE *asmFile);
void write_lt(FILE *asmFile);
void write_and(FILE *asmFile);
void write_or(FILE *asmFile);
void write_not(FILE *asmFile);

void write_label(char labelName[], FILE *asmFile);
void write_goto(char labelName[], FILE *asmFile);
void write_ifGoto(char labelName[], FILE *asmFile);

void write_function(char functionName[], char localVarsNum[], FILE *asmFile);
void write_call(char functionName[], char argsNum[], FILE *asmFile);
void write_return(FILE *asmFile);

void write_end(FILE *asmFile);