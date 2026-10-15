#frozen_string_literal: true

# The code maker uses a combination of the pegs available to set a code
class CodeMaker
  def initialize; end
  
  def place_code(board)
    code = @board.pegs.sample(4)
    
    @board.store_code(code)
  end

  def correct_guess?(guess, code)
    guess.eql?(code)
  end

  def check_pegs(pegs, code)
    feedback = []

    pegs.each_with_index do |peg, position|
      if code.include?(peg) && code[position] == peg
        feedback.push('x')
        next
      end

      feedback.push('o') if code.include?(peg) && !code[position] == peg
    end

    feedback
  end

  def give_feedback(board)
    last_guess = board.guesses[-1]
    code = board.code

    return if correct_guess?(last_guess, code)

    check_pegs(last_guess, code)
  end
end