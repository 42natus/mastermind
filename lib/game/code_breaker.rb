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

  def valid?(guess, pegs)
    guess.length == 4 && guess.none? { |ch| !pegs.include?(ch) }
  end

  def guess(board)
    guess = []
    pegs = board.pegs

    until valid?(guess, pegs)
      print 'Enter your guess: '
      guess = sanitize(gets.chomp)
    end

    board.store_guess(guess)
  end
end
