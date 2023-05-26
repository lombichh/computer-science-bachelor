#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "code_writer.h"
#include "cache.h"

char current_function_name[50];
char current_input_file[50];

// constant assembly commands
const char push[] = "@SP\nM=M+1\nA=M-1\nM=D\n",
    pop[] = "@SP\nAM=M-1\nD=M\n";

// counters for labels
int return_address_id = 0;
int true_false_id = 0;

// cache
call_node *calls_cache = NULL;
int is_return_in_cache = 0;

void change_input_file(char input_file[]) {
    strcpy(current_input_file, input_file);
}

void write_initialize_sp(FILE *asm_file) {
    fprintf(asm_file, "// initialization\n@256\nD=A\n@SP\nM=D\n");
}

void get_segment_id(char *segment_id, char *segment) {
    if (strcmp(segment, "local") == 0)
        strcpy(segment_id, "LCL");
    else if (strcmp(segment, "argument") == 0)
        strcpy(segment_id, "ARG");
    else if (strcmp(segment, "this") == 0)
        strcpy(segment_id, "THIS");
    else if (strcmp(segment, "that") == 0)
        strcpy(segment_id, "THAT");
}

void write_push(char *segment, char *num, FILE *asm_file) {
    fprintf(asm_file, "// push %s %s\n", segment, num);

    if (strcmp(segment, "constant") == 0) {
        if (atoi(num) < 2) fprintf(asm_file, "@SP\nM=M+1\nA=M-1\nM=%s\n", num);
        else fprintf(asm_file, "@%s\nD=A\n%s", num, push);
    } else if (strcmp(segment, "static") == 0) {
        fprintf(asm_file, "@%s.%s\nD=M\n%s", current_input_file, num, push);
    } else if (strcmp(segment, "pointer") == 0) {
        char segment_id[5];
        if (atoi(num) == 0) strcpy(segment_id, "THIS");
        else strcpy(segment_id, "THAT");

        fprintf(asm_file, "@%s\nD=M\n%s", segment_id, push);
    } else if (strcmp(segment, "temp") == 0) {
        fprintf(asm_file, "@R%d\nD=M\n%s", 5 + atoi(num), push);
    } else {
        // offset segments
        char segment_id[5];
        get_segment_id(segment_id, segment);

        fprintf(asm_file, "@%s\n", segment_id);
        if (atoi(num) > 0) {
            if (atoi(num) == 1) fprintf(asm_file, "A=M+1\n");
            else fprintf(asm_file, "D=M\n@%s\nA=D+A\n", num);
        } else fprintf(asm_file, "A=M\n");
        fprintf(asm_file, "D=M\n%s", push);
    }
}

void write_pop(char *segment, char *num, FILE *asm_file) {
    fprintf(asm_file, "// pop %s %s\n", segment, num);
    
    if (strcmp(segment, "static") == 0) {
        fprintf(asm_file, "%s@%s.%s\nM=D\n", pop, current_input_file, num);
    } else if (strcmp(segment, "pointer") == 0) {
        char segment_id[5];
        if (atoi(num) == 0) strcpy(segment_id, "THIS");
        else strcpy(segment_id, "THAT");

        fprintf(asm_file, "%s@%s\nM=D\n", pop, segment_id);
    } else if (strcmp(segment, "temp") == 0) {
        fprintf(asm_file, "%s@R%d\nM=D\n", pop, 5 + atoi(num));
    } else {
        // offset segments
        char segment_id[5];
        get_segment_id(segment_id, segment);

        fprintf(asm_file, "@%s\n", segment_id);
        if (atoi(num) > 0) {
            if (atoi(num) == 1) fprintf(asm_file, "D=M+1\n");
            else fprintf(asm_file, "D=M\n@%s\nD=D+A\n", num);
        } else fprintf(asm_file, "D=M\n");
        fprintf(asm_file, "@R13\nM=D\n%s@R13\nA=M\nM=D\n", pop);
    }
}

void write_add(FILE *asm_file) {
    fprintf(asm_file, "// add\n");
    
    fprintf(asm_file, "@SP\nAMD=M-1\nD=M\nA=A-1\nM=M+D\n");
}

void write_sub(FILE *asm_file) {
    fprintf(asm_file, "// sub\n");
    
    fprintf(asm_file, "@SP\nAMD=M-1\nD=M\nA=A-1\nM=M-D\n");
}

void write_neg(FILE *asm_file) {
    fprintf(asm_file, "// neg\n");
    
    fprintf(asm_file, "@SP\nA=M-1\nM=-M\n");
}

void write_eq(FILE *asm_file) {
    fprintf(asm_file, "// eq\n");
    
    fprintf(asm_file,
        "@SP\nAMD=M-1\nD=M\nA=A-1\nMD=M-D\n@LabelTrue%d\n"
        "D;JEQ\n@LabelFalse%d\nD=0;JMP\n(LabelTrue%d)\n"
        "D=-1\n(LabelFalse%d)\n@SP\nA=M-1\nM=D\n",
        true_false_id, true_false_id, true_false_id, true_false_id
    );

    true_false_id++;
}

void write_gt(FILE *asm_file) {
    fprintf(asm_file, "// gt\n");
    
    fprintf(asm_file,
        "@SP\nAMD=M-1\nD=M\nA=A-1\nMD=M-D\n@LabelTrue%d\n"
        "D;JGT\n@LabelFalse%d\nD=0;JMP\n(LabelTrue%d)\n"
        "D=-1\n(LabelFalse%d)\n@SP\nA=M-1\nM=D\n",
        true_false_id, true_false_id, true_false_id, true_false_id
    );

    true_false_id++;
}

void write_lt(FILE *asm_file) {
    fprintf(asm_file, "// lt\n");
    
    fprintf(asm_file,
        "@SP\nAMD=M-1\nD=M\nA=A-1\nMD=M-D\n@LabelTrue%d\n"
        "D;JLT\n@LabelFalse%d\nD=0;JMP\n(LabelTrue%d)\n"
        "D=-1\n(LabelFalse%d)\n@SP\nA=M-1\nM=D\n",
        true_false_id, true_false_id, true_false_id, true_false_id
    );

    true_false_id++;
}

void write_and(FILE *asm_file) {
    fprintf(asm_file, "// and\n");
    
    fprintf(asm_file, "@SP\nAMD=M-1\nD=M\nA=A-1\nM=M&D\n");
}

void write_or(FILE *asm_file) {
    fprintf(asm_file, "// or\n");
    
    fprintf(asm_file, "@SP\nAMD=M-1\nD=M\nA=A-1\nM=M|D\n");
}

void write_not(FILE *asm_file) {
    fprintf(asm_file, "// not\n");
    
    fprintf(asm_file, "@SP\nA=M-1\nM=!M\n");
}

void write_label(char *label_name, FILE *asm_file) {
    fprintf(asm_file, "// label %s\n", label_name);
    
    fprintf(asm_file, "(%s.%s)\n", current_function_name, label_name);
}

void write_goto(char *label_name, FILE *asm_file) {
    fprintf(asm_file, "// goto %s\n", label_name);
    
    fprintf(asm_file, "@%s.%s\n0;JMP\n", current_function_name, label_name);
}

void write_ifGoto(char *label_name, FILE *asm_file) {
    fprintf(asm_file, "// if-goto %s\n", label_name);
    
    fprintf(asm_file, "%s@%s.%s\nD;JNE\n", pop, current_function_name, label_name);
}

void write_function(char *function_name, char *local_vars_num, FILE *asm_file) {
    fprintf(asm_file, "// function %s %s\n", function_name, local_vars_num);

    strcpy(current_function_name, function_name);
    
    // label [function_name]
    fprintf(asm_file, "(%s)\n", function_name);

    if (atoi(local_vars_num) > 0) {
        // increment SP of local_vars_num
        if (atoi(local_vars_num) == 1)
            fprintf(asm_file, "@SP\nM=M+1\nA=M-1\n");
        else fprintf(asm_file, "@%s\nD=A\n@SP\nM=M+D\nA=M-D\n", local_vars_num);

        for (int i = 0; i < atoi(local_vars_num); i++) {
            fprintf(asm_file, "M=0\nA=A+1\n");
        }
    }
}

void write_call(char *function_name, char *args_num, FILE *asm_file) {
    fprintf(asm_file, "// call %s %s\n", function_name, args_num);
    
    call_node current_call;
    strcpy(current_call.function_name, function_name);
    current_call.args_num = atoi(args_num);
    
    // push returnAddress
    fprintf(asm_file, "@ReturnAddress.%d\nD=A\n@SP\nM=M+1\nA=M-1\nM=D\n", return_address_id);
    if (is_call_in_cache(calls_cache, current_call)) {
        // jump to call in cache
        fprintf(asm_file, "@%s.%s\n0;JMP\n", function_name, args_num);
    } else {
        // push label for next calls
        fprintf(asm_file, "(%s.%s)\n", function_name, args_num);
        // push old LCL
        fprintf(asm_file, "@LCL\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
        // push old ARG
        fprintf(asm_file, "@ARG\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
        // push old THIS
        fprintf(asm_file, "@THIS\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
        // push old THAT
        fprintf(asm_file, "@THAT\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
        // LCL = SP
        fprintf(asm_file, "D=A+1\n@LCL\nM=D\n");
        // ARG = SP - 5 - [args_num]
        fprintf(asm_file, "@%d\nD=D-A\n@ARG\nM=D\n", atoi(args_num) + 5);
        // goto [function_name] 
        fprintf(asm_file, "@%s\n0;JMP\n", function_name);
        
        calls_cache = add_call_to_cache(calls_cache, current_call);
    }
    // label [function_name]ReturnAddress.[id]
    fprintf(asm_file, "(ReturnAddress.%d)\n", return_address_id);

    return_address_id++;
}

void write_return(FILE *asm_file) {
    fprintf(asm_file, "// return\n");
    
    if (is_return_in_cache) {
        // jump to return in cache
        fprintf(asm_file, "@.return\n0;JMP\n");
    } else {
        
        // push label for next returns
        fprintf(asm_file, "(.return)\n");
        // pop R14 (return value)
        fprintf(asm_file, "@SP\nAM=M-1\nD=M\n@R14\nM=D\n");
        // SP = ARG
        fprintf(asm_file, "@ARG\nD=M\n@SP\nM=D\n");
        // PTR = LCL
        fprintf(asm_file, "@LCL\nD=M\n@R13\nM=D\n");
        // LCL = old LCL
        fprintf(asm_file, "@R13\nD=M\n@4\nD=D-A\nA=D\nD=M\n@LCL\nM=D\n");
        // ARG = old ARG
        fprintf(asm_file, "@R13\nD=M\n@3\nD=D-A\nA=D\nD=M\n@ARG\nM=D\n");
        // THIS = old THIS
        fprintf(asm_file, "@R13\nD=M\n@2\nD=D-A\nA=D\nD=M\n@THIS\nM=D\n");
        // THAT = old THAT
        fprintf(asm_file, "@R13\nD=M\n@1\nD=D-A\nA=D\nD=M\n@THAT\nM=D\n");
        // R13 = returnAddress
        fprintf(asm_file, "@R13\nD=M\n@5\nD=D-A\nA=D\nD=M\n@R13\nM=D\n");
        // push R14 (return value)
        fprintf(asm_file, "@R14\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
        // goto [function_name]ReturnAddress
        fprintf(asm_file, "@R13\nA=M\n0;JMP\n");

        is_return_in_cache = 1;
    }
}

void write_end(FILE *asm_file) {
    fprintf(asm_file, "// end loop\n");
    
    fprintf(asm_file, "(END)\n@END\n0;JMP\n");
}
