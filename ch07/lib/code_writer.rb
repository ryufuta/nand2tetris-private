# frozen_string_literal: true

class CodeWriter
  def initialize(file_path)
    @file = File.open(file_path, 'w')
    @next_label_index = 0
  end

  def write_arithmetic(command)
    case command
    when 'add'
      asm = <<~ASM
        @SP
        A=M-1
        D=M
        A=A-1
        M=D+M
        @SP
        M=M-1
      ASM
    when 'eq'
      asm = <<~ASM
        @SP
        A=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @EQ_TRUE#{@next_label_index}
        D;JEQ
        @EQ_END#{@next_label_index}
        0;JMP
        (EQ_TRUE#{@next_label_index})
        @SP
        A=M-1
        A=A-1
        M=-1
        (EQ_END#{@next_label_index})
        @SP
        M=M-1
      ASM
      @next_label_index += 1
    else
      asm = '// To be Implemented'
    end
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
