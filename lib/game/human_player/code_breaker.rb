# frozen_string_literal: true

module HumanPlayer
  # The code breaker guesses by placing a combination of pegs on the board in an
  # attempt to deduce the code set by the code maker
  class CodeBreaker
    attr_accessor :correct_guess

    def initialize(board)
      @board = board
      @correct_guess = false
    end

    def to_s
      'human'
    end

    def sanitize(guess)
      guess.gsub(' ', '').chars
    end

    def valid?(guess, pegs)
      guess.length == 4 && guess.none? { |ch| !pegs.include?(ch) }
    end

    def guess
      guess = []
      pegs = @board.pegs

      until valid?(guess, pegs)
        print 'Enter your guess: '
        guess = sanitize(gets.chomp)
      end

      @board.store_guess(guess)
    end
  end
end
