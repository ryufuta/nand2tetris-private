# frozen_string_literal: true

class Parser
  def initialize(file_path)
    @lines = File.readlines(file_path).map(&:chomp)
    @index = -1
  end

  def has_more_lines?
    @index < @lines.length - 1
  end

  def advance
    loop do
      @index += 1
      break if instruction?
    end
  end

  def instruction_type
    if current_line.start_with?('@')
      :A_INSTRUCTION
    elsif current_line.start_with?('(') && current_line.end_with?(')')
      :L_INSTRUCTION
    else
      :C_INSTRUCTION
    end
  end

  def symbol
    case instruction_type
    when :A_INSTRUCTION
      current_line[1..-1]
    when :L_INSTRUCTION
      current_line[1..-2]
    end
  end

  def dest
    current_line[/^(.*?)=/, 1] || 'null'
  end

  def comp
    # Extract the comp part from C_COMMAND
    # For example, for "D=A+1;JGT", comp would be "A+1"
    # for "D;JGT", comp would be "D"
    # for "D=A+1", comp would be "A+1"
    # for "M", comp would be "M"
    current_line[/=(.*?)(;|$)/, 1] || current_line[/^(.*?)(;|$)/, 1]
    # current_line.sub(/^.*=/, '').sub(/;.*$/, '')
  end

  def jump
    current_line[/;(.*)$/, 1] || 'null'
  end

  private

  def current_line
    @lines[@index].strip
  end

  def instruction?
    !current_line.empty? && !current_line.start_with?('//')
  end
end
