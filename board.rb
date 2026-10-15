#frozen_string_literal: true

# This is the board upon which the game will be played. The codemaker sets the
# code and the codebreaker makes guesses on this board.
class Board
  attr_reader :pegs, :code

  def initialize
    @pegs = %w(1 2 3 4 5 6)
    
    @code = []
    @guesses = []
    @feedbacks = []
  end

  def store_code(pegs)
    @code = code
  end

  def store_guess(pegs)
    @guesses << guess
  end

  def store_feedback(pegs)
    @feedbacks << pegs
  end
end