// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
// eq
  // yを取り出す
@SP
A=M-1
D=M
  // xを取り出してx-yを計算
A=A-1
D=M-D
  // xの位置にfalseを代入
M=0
  // if (x-y == 0) goto EQ_TRUE0
@EQ_TRUE0
D;JEQ
  // else goto EQ_END0
@EQ_END0
0;JMP

(EQ_TRUE0)
  // xの位置にtrueを代入
@SP
A=M-1
A=A-1
M=-1

(EQ_END0)
  // SP--
@SP
M=M-1

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 16
@16
D=A
@SP
A=M
M=D
@SP
M=M+1
// eq
@SP
A=M-1
D=M
A=A-1
D=M-D
M=0
@EQ_TRUE1
D;JEQ
@EQ_END1
0;JMP
(EQ_TRUE1)
@SP
A=M-1
A=A-1
M=-1
(EQ_END1)
@SP
M=M-1
// push constant 16
@16
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1
// eq
@SP
A=M-1
D=M
A=A-1
D=M-D
M=0
@EQ_TRUE2
D;JEQ
@EQ_END2
0;JMP
(EQ_TRUE2)
@SP
A=M-1
A=A-1
M=-1
(EQ_END2)
@SP
M=M-1
