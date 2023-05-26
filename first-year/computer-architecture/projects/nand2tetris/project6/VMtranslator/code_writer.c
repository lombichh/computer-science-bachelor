#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int labelTrueFalseId = 0;
int labelFunctionReturnAddressId = 0;
int STC = 16; // static segment pointer

void write_initialize_sp(FILE *asmFile) {
    fprintf(asmFile, "@256\nD=A\n@SP\nM=D\n");
}

void write_push(char segment[], char num[], FILE *asmFile) {
    if (strcmp(segment, "constant") == 0) {
        fprintf(asmFile, "@%s\nD=A\n", num);
    } else if (strcmp(segment, "static") == 0) {
        fprintf(asmFile, "@staticVar%s\nD=M\n", num);
    } else if (strcmp(segment, "local") == 0) {
        fprintf(asmFile, "@LCL\nD=M\n@%s\nA=D+A\nD=M\n", num);
    } else if (strcmp(segment, "argument") == 0) {
        fprintf(asmFile, "@ARG\nD=M\n@%s\nA=D+A\nD=M\n", num);
    }

    fprintf(asmFile, "@SP\nM=M+1\nA=M-1\nM=D\n");
}

void write_pop(char segment[], char num[], FILE *asmFile) {
    if (strcmp(segment, "static") == 0) {
        fprintf(asmFile, "@SP\nAM=M-1\nD=M\n@staticVar%s\nM=D\n", num);
    } else {
        if (strcmp(segment, "local") == 0) {
            fprintf(asmFile, "@LCL\nD=M\n@%s\nD=D+A\n", num);
        } else if (strcmp(segment, "argument") == 0) {
            fprintf(asmFile, "@ARG\nD=M\n@%s\nD=D+A\n", num);
        }
        
        fprintf(asmFile, "@R13\nM=D\n@SP\nAM=M-1\nD=M\n@R13\nA=M\nM=D\n");
    }

}

void write_add(FILE *asmFile) {
    fprintf(asmFile, "@SP\nAM=M-1\nD=M\nA=A-1\nM=M+D\n");
}

void write_sub(FILE *asmFile) {
    fprintf(asmFile, "@SP\nAM=M-1\nD=M\nA=A-1\nM=M-D\n");
}

void write_neg(FILE *asmFile) {
    fprintf(asmFile, "@SP\nA=M-1\nM=-M\n");
}

void write_eq(FILE *asmFile) {
    fprintf(asmFile,
        "@SP\nA=M-1\nD=M\nA=A-1\nD=M-D\n@labelTrue%d\nD;JEQ\nD=0\n@labelFalse%d\n0;JMP\n(labelTrue%d)\nD=-1\n(labelFalse%d)\n@SP\nAM=M-1\nA=A-1\nM=D\n",
        labelTrueFalseId, labelTrueFalseId, labelTrueFalseId, labelTrueFalseId
    );
    labelTrueFalseId++;
}

void write_gt(FILE *asmFile) {
    fprintf(asmFile,
        "@SP\nA=M-1\nD=M\nA=A-1\nD=M-D\n@labelTrue%d\nD;JGT\nD=0\n@labelFalse%d\n0;JMP\n(labelTrue%d)\nD=-1\n(labelFalse%d)\n@SP\nAM=M-1\nA=A-1\nM=D\n",
        labelTrueFalseId, labelTrueFalseId, labelTrueFalseId, labelTrueFalseId
    );
    labelTrueFalseId++;
}

void write_lt(FILE *asmFile) {
    fprintf(asmFile,
        "@SP\nA=M-1\nD=M\nA=A-1\nD=M-D\n@labelTrue%d\nD;JLT\nD=0\n@labelFalse%d\n0;JMP\n(labelTrue%d)\nD=-1\n(labelFalse%d)\n@SP\nAM=M-1\nA=A-1\nM=D\n",
        labelTrueFalseId, labelTrueFalseId, labelTrueFalseId, labelTrueFalseId
    );
    labelTrueFalseId++;
}

void write_and(FILE *asmFile) {
    fprintf(asmFile, "@SP\nAM=M-1\nD=M\nA=A-1\nM=D&M\n");
}

void write_or(FILE *asmFile) {
    fprintf(asmFile, "@SP\nAM=M-1\nD=M\nA=A-1\nM=D|M\n");
}

void write_not(FILE *asmFile) {
    fprintf(asmFile, "@SP\nA=M-1\nM=!M\n");
}

void write_label(char labelName[], FILE *asmFile) {
    fprintf(asmFile, "(%s)\n", labelName);
}

void write_goto(char labelName[], FILE *asmFile) {
    fprintf(asmFile, "@%s\n0;JMP\n", labelName);
}

void write_ifGoto(char labelName[], FILE *asmFile) {
    fprintf(asmFile, "@SP\nAM=M-1\nD=M\n@%s\nD;JNE\n", labelName);
}

void write_function(char functionName[], char localVarsNum[], FILE *asmFile) {
    fprintf(asmFile, "(%s)\n", functionName);

    for (int i = 0; i < atoi(localVarsNum); i++) {
        fprintf(asmFile, "@0\nD=A\n@SP\nM=M+1\nA=M-1\nM=D\n");
    }
}

void write_call(char functionName[], char argsNum[], FILE *asmFile) {
    // push returnAddress
    fprintf(asmFile, "@%sReturnAddress%d\nD=A\n@SP\nM=M+1\nA=M-1\nM=D\n",
        functionName, labelFunctionReturnAddressId);
    // push old LCL
    fprintf(asmFile, "@LCL\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
    // push old ARG
    fprintf(asmFile, "@ARG\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
    // push old THIS
    fprintf(asmFile, "@THIS\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
    // push old THAT
    fprintf(asmFile, "@THAT\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
    // LCL = SP
    fprintf(asmFile, "@SP\nD=M\n@LCL\nM=D\n");
    // ARG = SP - 5 - [argsNum]
    fprintf(asmFile, "@SP\nD=M\n@5\nD=D-A\n@%s\nD=D-A\n@ARG\nM=D\n", argsNum);
    // goto [functionName] 
    fprintf(asmFile, "@%s\n0;JMP\n", functionName);
    // label [functionName]ReturnAddress
    fprintf(asmFile, "(%sReturnAddress%d)\n", functionName, labelFunctionReturnAddressId);

    labelFunctionReturnAddressId++;
}

void write_return(FILE *asmFile) {
    // pop R14 (return value)
    fprintf(asmFile, "@SP\nAM=M-1\nD=M\n@R14\nM=D\n");
    // SP = ARG
    fprintf(asmFile, "@ARG\nD=M\n@SP\nM=D\n");
    // PTR = LCL
    fprintf(asmFile, "@LCL\nD=M\n@R13\nM=D\n");
    // LCL = old LCL
    fprintf(asmFile, "@R13\nD=M\n@4\nD=D-A\nA=D\nD=M\n@LCL\nM=D\n");
    // ARG = old ARG
    fprintf(asmFile, "@R13\nD=M\n@3\nD=D-A\nA=D\nD=M\n@ARG\nM=D\n");
    // THIS = old THIS
    fprintf(asmFile, "@R13\nD=M\n@2\nD=D-A\nA=D\nD=M\n@THIS\nM=D\n");
    // THAT = old THAT
    fprintf(asmFile, "@R13\nD=M\n@1\nD=D-A\nA=D\nD=M\n@THAT\nM=D\n");
    // R13 = returnAddress
    fprintf(asmFile, "@R13\nD=M\n@5\nD=D-A\nA=D\nD=M\n@R13\nM=D\n");
    // push R14 (return value)
    fprintf(asmFile, "@R14\nD=M\n@SP\nM=M+1\nA=M-1\nM=D\n");
    // goto [functionName]ReturnAddress
    fprintf(asmFile, "@R13\nA=M\n0;JMP\n");
}

void write_end(FILE *asmFile) {
    fprintf(asmFile, "(END)\n@END\n0;JMP\n");
}