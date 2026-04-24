# frozen_string_literal: true

class Code
  JUMP_TABLE = {
    'null' => '000',
    'JGT' => '001',
    'JEQ' => '010',
    'JGE' => '011',
    'JLT' => '100',
    'JNE' => '101',
    'JLE' => '110',
    'JMP' => '111'
  }.freeze

  def dest(mnemonic)
    result = 0
    result |= 1 if mnemonic.include?('M')
    result |= 2 if mnemonic.include?('D')
    result |= 4 if mnemonic.include?('A')
    result.to_s(2).rjust(3, '0')
  end

  def comp(mnemonic)
    a = mnemonic.include?('M') ? '1' : '0'
    cccccc = case mnemonic
    when '0' then '101010'
    when '1' then '111111'
    when '-1' then '111010'
    when 'D' then '001100'
    when 'A', 'M' then '110000'
    when '!D' then '001101'
    when '!A', '!M' then '110001'
    when '-D' then '001111'
    when '-A', '-M' then '110011'
    when 'D+1' then '011111'
    when 'A+1', 'M+1' then '110111'
    when 'D-1' then '001110'
    when 'A-1', 'M-1' then '110010'
    when 'D+A', 'D+M' then '000010'
    when 'D-A', 'D-M' then '010011'
    when 'A-D', 'M-D' then '000111'
    when 'D&A', 'D&M' then '000000'
    when 'D|A', 'D|M' then '010101'
    end
    "#{a}#{cccccc}"
  end

  def jump(mnemonic)
    JUMP_TABLE[mnemonic]
  end
end
