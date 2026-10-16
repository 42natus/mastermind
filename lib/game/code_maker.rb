#frozen_string_literal: true

# The code maker uses a combination of the pegs available to set a code
class CodeMaker
  def initialize; end
  
  def place_code(board)
    code = board.pegs.sample(4)
    
    board.store_code(code)
  end

  def correct_guess?(guess, code)
    guess.eql?(code)
  end

  def check_pegs(pegs, code)
    feedback = []

    # check if each peg's in the code AND in the correct position
    pegs.each_with_index do |peg, position|
      if code[position] == peg
        feedback.push('x')
        # value ignorable cos it's been assessed — won't affect next check
        code[position] = '_'
      end
    end

    # any pegs present in the code after last check are in the wrong position
    pegs.each_with_index do |peg, position|
      if code.include?(peg)
        feedback.push('o')
        code[code.index(peg)] = '_'
      end
    end

    feedback
  end

  def give_feedback(board)
    last_guess = board.guesses[-1]

    code = board.code.clone

    return if correct_guess?(last_guess, code)

    board.store_feedback(check_pegs(last_guess, code))
  end
end
