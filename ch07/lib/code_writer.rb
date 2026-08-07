# frozen_string_literal: true

class CodeWriter
  AL_TABLE = {
    'add' => 'D+M',
    'sub' => 'M-D',
    'and' => 'D&M',
    'or' => 'D|M',
    'neg' => '-M',
    'not' => '!M',
  }.freeze

  SYMBOL_TABLE = {
    'local' => 'LCL',
    'argument' => 'ARG',
    'this' => 'THIS',
    'that' => 'THAT',
  }.freeze

  def initialize(file_path)
    @file = File.open(file_path, 'w')
    @next_label_index = 0
  end

  def write_arithmetic(command)
    case command
    when 'add', 'sub', 'and', 'or'
      asm = <<~ASM
        @SP
        A=M-1
        D=M
        A=A-1
        M=#{AL_TABLE[command]}
        @SP
        M=M-1
      ASM
    when 'eq', 'lt', 'gt'
      asm = <<~ASM
        @SP
        A=M-1
        D=M
        A=A-1
        D=M-D
        M=0
        @COMPARE_TRUE#{@next_label_index}
        D;J#{command.upcase}
        @COMPARE_END#{@next_label_index}
        0;JMP
        (COMPARE_TRUE#{@next_label_index})
        @SP
        A=M-1
        A=A-1
        M=-1
        (COMPARE_END#{@next_label_index})
        @SP
        M=M-1
      ASM
      @next_label_index += 1
    when 'neg', 'not'
      asm = <<~ASM
        @SP
        A=M-1
        M=#{AL_TABLE[command]}
      ASM
    end
    @file.puts(asm)
  end

  def write_push_pop(command, segment, index)
    case command
    when :C_PUSH
      if segment == 'constant'
        asm = <<~ASM
          @#{index}
          D=A
          @SP
          A=M
          M=D
          @SP
          M=M+1
        ASM
      else
        asm = '// push: To be implemented'
      end
    when :C_POP
      case segment
      when 'local', 'argument', 'this', 'that'
        asm = <<~ASM
          @#{index}
          D=A
          @#{SYMBOL_TABLE[segment]}
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
        ASM
      else
        asm = '// pop: To be implemented'
      end
    end
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
