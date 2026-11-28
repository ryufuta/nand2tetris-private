// bootstrap
// SP=256
@256
D=A
@SP
M=D
// call Sys.init
  // push returnAddress
@$ret.0
D=A
@SP
AM=M+1
A=A-1
M=D
  // push LCL
@LCL
D=M
@SP
AM=M+1
A=A-1
M=D
  // push ARG
@ARG
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THIS
@THIS
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THAT
@THAT
D=M
@SP
AM=M+1
A=A-1
M=D
  // ARG = SP-5-nArgs
@SP
D=M
@5
D=D-A
@ARG
M=D
  // LCL = SP
@SP
D=M
@LCL
M=D
  // goto f
@Sys.init
0;JMP

($ret.0)

// Sys.vm
(Sys.init)
@4
D=A
@SP
AM=M+1
A=A-1
M=D
// call Main.fibonacci 1
  // push returnAddress
@Sys.init$ret.0
D=A
@SP
AM=M+1
A=A-1
M=D
  // push LCL
@LCL
D=M
@SP
AM=M+1
A=A-1
M=D
  // push ARG
@ARG
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THIS
@THIS
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THAT
@THAT
D=M
@SP
AM=M+1
A=A-1
M=D
  // ARG = SP-5-nArgs
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
  // LCL = SP
@SP
D=M
@LCL
M=D
  // goto f
@Main.fibonacci
0;JMP

(Sys.init$ret.0)

(WHILE)
@WHILE
0;JMP

// Main.vm
(Main.fibonacci)
@0
D=A
@ARG
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@2
D=A
@SP
AM=M+1
A=A-1
M=D
@SP
AM=M-1
D=M
A=A-1
D=M-D
M=0
@COMPARE_TRUE0
D;JLT
@COMPARE_END0
0;JMP
(COMPARE_TRUE0)
@SP
A=M-1
M=-1
(COMPARE_END0)
@SP
AM=M-1
D=M
@IF_TRUE
D;JNE
@IF_FALSE
0;JMP
(IF_TRUE)
@0
D=A
@ARG
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@LCL
D=M
@R13
M=D
@5
D=A
@R13
A=M-D
D=M
@R14
M=D
@SP
AM=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R13
AM=M-1
D=M
@THAT
M=D
@R13
AM=M-1
D=M
@THIS
M=D
@R13
AM=M-1
D=M
@ARG
M=D
@R13
AM=M-1
D=M
@LCL
M=D
@R14
A=M
0;JMP
(IF_FALSE)
@0
D=A
@ARG
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@2
D=A
@SP
AM=M+1
A=A-1
M=D
@SP
AM=M-1
D=M
A=A-1
M=M-D
// call Main.fibonacci 1  // computes fib(n-2)
  // push returnAddress
@Main.fibonacci$ret.0
D=A
@SP
AM=M+1
A=A-1
M=D
  // push LCL
@LCL
D=M
@SP
AM=M+1
A=A-1
M=D
  // push ARG
@ARG
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THIS
@THIS
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THAT
@THAT
D=M
@SP
AM=M+1
A=A-1
M=D
  // ARG = SP-5-nArgs
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
  // LCL = SP
@SP
D=M
@LCL
M=D
  // goto f
@Main.fibonacci
0;JMP

(Main.fibonacci$ret.0)

@0
D=A
@ARG
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@1
D=A
@SP
AM=M+1
A=A-1
M=D
@SP
AM=M-1
D=M
A=A-1
M=M-D
// call Main.fibonacci 1  // computes fib(n-1)
  // push returnAddress
@Main.fibonacci$ret.1
D=A
@SP
AM=M+1
A=A-1
M=D
  // push LCL
@LCL
D=M
@SP
AM=M+1
A=A-1
M=D
  // push ARG
@ARG
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THIS
@THIS
D=M
@SP
AM=M+1
A=A-1
M=D
  // push THAT
@THAT
D=M
@SP
AM=M+1
A=A-1
M=D
  // ARG = SP-5-nArgs
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
  // LCL = SP
@SP
D=M
@LCL
M=D
  // goto f
@Main.fibonacci
0;JMP

(Main.fibonacci$ret.1)

@SP
AM=M-1
D=M
A=A-1
M=D+M
@LCL
D=M
@R13
M=D
@5
D=A
@R13
A=M-D
D=M
@R14
M=D
@SP
AM=M-1
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R13
AM=M-1
D=M
@THAT
M=D
@R13
AM=M-1
D=M
@THIS
M=D
@R13
AM=M-1
D=M
@ARG
M=D
@R13
AM=M-1
D=M
@LCL
M=D
@R14
A=M
0;JMP
(END)
@END
0;JMP
