# frozen_string_literal: true

class SymbolTable
  def initialize
    @table = predefined_symbols
  end

  def add_entry(symbol, address)
    @table[symbol] = address
  end

  def contains?(symbol)
    @table.key?(symbol)
  end

  def get_address(symbol)
    @table[symbol]
  end

  private

  def predefined_symbols
    table = {
      'SP' => 0,
      'LCL' => 1,
      'ARG' => 2,
      'THIS' => 3,
      'THAT' => 4,
      'SCREEN' => 16384,
      'KBD' => 24576
    }

    16.times { |i| table["R#{i}"] = i }

    table
  end
end
