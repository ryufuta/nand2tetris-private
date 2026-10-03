// TODO: implements function
(SimpleFunction.test)
  // repeat 2 times:
  // push 0
@LCL
A=M
M=0
A=A+1
M=0

@0
D=A
@LCL
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@1
D=A
@LCL
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@SP
AM=M-1
D=M
A=A-1
M=D+M
@SP
A=M-1
M=!M
@0
D=A
@ARG
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@SP
AM=M-1
D=M
A=A-1
M=D+M
@1
D=A
@ARG
A=D+M
D=M
@SP
AM=M+1
A=A-1
M=D
@SP
AM=M-1
D=M
A=A-1
M=M-D
// TODO: implements return
  // frame = LCL // frameは一時変数
@LCL
D=M
    // R13をframeの格納先にする
@R13
M=D
  // retAddr = *(frame-5) // returnアドレスを一時変数に入れる
    // D = *(frame-5)
@5
D=A
@R13
A=M-D
D=M
    // retAddr = D
    // R14をretAddrの格納先にする
@R14
M=D
  // *ARG = pop() // 呼び出し側の戻り値を別の場所に移す
@SP
AM=M-1
D=M
@ARG
A=M
M=D
  // SP = ARG+1 // 呼び出し側のSPを別の場所に移す
@ARG
D=M+1
@SP
M=D
  // THAT = *(frame-1) // 呼び出し側のTHATを復元する
@R13
A=M-1
D=M
@THAT
M=D
  // THIS = *(frame-2) // 呼び出し側のTHISを復元する
@2
D=A
@R13
A=M-D
D=M
@THIS
M=D
  // ARG = *(frame-3) // 呼び出し側のARGを復元する
@3
D=A
@R13
A=M-D
D=M
@ARG
M=D
  // LCL = *(frame-4) // 呼び出し側のLCLを復元する
@4
D=A
@R13
A=M-D
D=M
@LCL
M=D
  // goto retAddr // returnアドレスへ移動する
@R14
A=M
0;JMP
(END)
@END
0;JMP
