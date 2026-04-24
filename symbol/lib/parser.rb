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
    current_line.sub(/^.*=/, '').sub(/;.*$/, '')
  end

  def jump
    current_line[/;(.*)$/, 1] || 'null'
  end

  def reset
    @index = -1
  end

  private

  def current_line
    @lines[@index].sub(/\/\/.*$/, '').strip
  end

  def instruction?
    !current_line.empty?
  end
end
