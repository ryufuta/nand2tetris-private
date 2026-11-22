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

  # RAM[++SP - 1]=D
  PUSH_D = <<~ASM.chomp
    @SP
    AM=M+1
    A=A-1
    M=D
  ASM

  # D=RAM[--SP]
  POP_TO_D = <<~ASM.chomp
    @SP
    AM=M-1
    D=M
  ASM

  def initialize(file_path, skip_bootstrap: false)
    @file = File.open(file_path, 'w')
    @next_label_index = 0
    @file_name = File.basename(file_path, '.asm')
    write_bootstrap unless skip_bootstrap
  end

  def set_file_name(file_name)
    # TODO: 新しいVMファイルの変換が開始されたことを知らせる
  end

  def write_arithmetic(command)
    case command
    when 'add', 'sub', 'and', 'or'
      asm = translate_binary_al(command)
    when 'eq', 'lt', 'gt'
      asm = translate_comparison(command)
      @next_label_index += 1
    when 'neg', 'not'
      asm = translate_unary_al(command)
    end
    @file.puts(asm)
  end

  def write_push_pop(command, segment, index)
    asm = case command
          when :C_PUSH
            case segment
            when 'constant'
              translate_push_constant(index)
            when 'local', 'argument', 'this', 'that'
              translate_push_seg_with_base_address(segment, index)
            when 'temp'
              translate_push_temp(index)
            when 'pointer'
              translate_push_pointer(index)
            when 'static'
              translate_push_static(index)
            end
          when :C_POP
            case segment
            when 'local', 'argument', 'this', 'that'
              translate_pop_seg_with_base_address(segment, index)
            when 'temp'
              translate_pop_temp(index)
            when 'pointer'
              translate_pop_pointer(index)
            when 'static'
              translate_pop_static(index)
            end
          end
    @file.puts(asm)
  end

  def write_label(label)
    @file.puts("(#{label})")
  end

  def write_goto(label)
    @file.puts(<<~ASM)
      @#{label}
      0;JMP
    ASM
  end

  def write_if(label)
    @file.puts(<<~ASM)
      #{POP_TO_D}
      @#{label}
      D;JNE
    ASM
  end

  def write_function(function_name, n_vars)
    asm = "(#{function_name})\n"
    if n_vars > 0
      asm += <<~ASM
        @LCL
        A=M
        M=0
      ASM

      asm += <<~ASM * (n_vars - 1)
        A=A+1
        M=0
      ASM
    end
    @file.puts(asm)
  end

  def write_call(function_name, n_args)
    @file.puts('// TODO: implements call')
  end

  def write_return
    @file.puts(<<~ASM)
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
    ASM
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

  private

  def write_bootstrap
    @file.puts('// TODO: implements bootstrap')
  end

  def translate_binary_al(command)
    <<~ASM
      #{POP_TO_D}
      A=A-1
      M=#{AL_TABLE[command]}
    ASM
  end

  def translate_unary_al(command)
    <<~ASM
      @SP
      A=M-1
      M=#{AL_TABLE[command]}
    ASM
  end

  def translate_comparison(command)
    <<~ASM
      #{POP_TO_D}
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
      M=-1
      (COMPARE_END#{@next_label_index})
    ASM
  end

  def translate_push_constant(index)
    <<~ASM
      @#{index}
      D=A
      #{PUSH_D}
    ASM
  end

  def translate_push_seg_with_base_address(segment, index)
    <<~ASM
      @#{index}
      D=A
      @#{SYMBOL_TABLE[segment]}
      A=D+M
      D=M
      #{PUSH_D}
    ASM
  end

  def translate_push_temp(index)
    <<~ASM
      @R#{5+index}
      D=M
      #{PUSH_D}
    ASM
  end

  def translate_push_pointer(index)
    <<~ASM
      @R#{3+index}
      D=M
      #{PUSH_D}
    ASM
  end

  def translate_push_static(index)
    <<~ASM
      @#{@file_name}.#{index}
      D=M
      #{PUSH_D}
    ASM
  end

  def translate_pop_seg_with_base_address(segment, index)
    <<~ASM
      @#{index}
      D=A
      @#{SYMBOL_TABLE[segment]}
      D=D+M
      @R13
      M=D
      #{POP_TO_D}
      @R13
      A=M
      M=D
    ASM
  end

  def translate_pop_temp(index)
    <<~ASM
      #{POP_TO_D}
      @R#{5+index}
      M=D
    ASM
  end

  def translate_pop_pointer(index)
    <<~ASM
      #{POP_TO_D}
      @R#{3+index}
      M=D
    ASM
  end

  def translate_pop_static(index)
    <<~ASM
      #{POP_TO_D}
      @#{@file_name}.#{index}
      M=D
    ASM
  end
end
