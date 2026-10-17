# frozen_string_literal: true

# The code breaker places a combination of the pegs on the board in an attempt
# to deduce the code set by the code maker
class CodeBreaker
  attr_accessor :correct_guess

  def initialize
    @correct_guess = false
  end

  def sanitize(guess)
    guess.gsub(' ', '').chars
  end

  def valid?(guess)
    guess = guess.join

    guess.length == 4 && guess.length == guess.to_i.to_s.length
  end

  def guess(board)
    guess = []

    until valid?(guess)
      print 'Enter your guess: '
      guess = sanitize(gets.chomp)
    end

    board.store_guess(guess)
  end
end
