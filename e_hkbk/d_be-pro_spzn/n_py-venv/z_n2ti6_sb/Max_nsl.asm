@R0
D=M              // D = first number
@R1
D=D-M            // D = first number - second number
@OUTPUT_FIRST
D;JGT            // if D>0 (first is greater) goto output_first
@R1
D=M              // D = second number
@OUTPUT_D
0;JMP            // goto output_d
@R0
D=M              // D = first number
@R2
M=D              // M[2] = D (greatest number)
@INFINITE_LOOP
0;JMP            // infinite loop