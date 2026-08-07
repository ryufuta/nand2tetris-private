@10
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@LCL
D=D+M
@R13
M=D
@SP
A=M-1
D=M
@R13
A=M
M=D
@SP
M=M-1
@21
D=A
@SP
A=M
M=D
@SP
M=M+1
@22
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop: To be implemented
// pop: To be implemented
@36
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop: To be implemented
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
@45
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop: To be implemented
// pop: To be implemented
@510
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop: To be implemented
// push: To be implemented
// push: To be implemented
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
// push: To be implemented
@SP
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1
// push: To be implemented
// push: To be implemented
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
@SP
A=M-1
D=M
A=A-1
M=M-D
@SP
M=M-1
// push: To be implemented
@SP
A=M-1
D=M
A=A-1
M=D+M
@SP
M=M-1
(END)
@END
0;JMP
