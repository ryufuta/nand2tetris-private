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
      break if command?
    end
  end

  def command_type
    case current_line.split(' ').first
    when 'push'
      :C_PUSH
    when 'add', 'sub', 'neg', 'eq', 'gt', 'lt', 'and', 'or', 'not'
      :C_ARITHMETIC
    end
  end

  def arg1
    if command_type == :C_ARITHMETIC
      current_line
    else
      current_line.split(' ')[1]
    end
  end

  def arg2
    current_line.split(' ')[2].to_i
  end

  private

  def current_line
    # コメント(`//`以降)と空白を削除
    @lines[@index].sub(/\/\/.*$/, '').strip
  end

  def command?
    !current_line.empty?
  end
end
