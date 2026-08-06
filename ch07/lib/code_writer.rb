# frozen_string_literal: true

class CodeWriter
  def initialize(file_path)
    @file = File.open(file_path, 'w')
  end

  def write_arithmetic(command)
    # add
    asm = <<~ASM
      @SP
      A=M-1
      D=M
      A=A-1
      M=D+M
      @SP
      M=M-1
    ASM
    @file.puts(asm)
  end

  def write_push_pop(command, segment, index)
    # push constant
    asm = <<~ASM
      @#{index}
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1
    ASM
    @file.puts(asm)
  end

  def close
    asm = <<~ASM
      (END)
      @END
      0;JMP
    ASM
    @file.puts(asm)
    @file.close
  end
end
