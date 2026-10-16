# frozen_string_literal: true

require_relative 'game/board'
require_relative 'game/code_maker'
require_relative 'game/code_breaker'

# This controls gameplay for a full round of the game
class Game
  def initialize
    @board = Board.new
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
  end

  def play
    @code_maker.place_code(@board)
    p @board.code

    12.times do
      @board.display
      
      @code_breaker.guess(@board)
      
      feedback = @code_maker.give_feedback(@board)
      
      if feedback.nil?
        @board.display(gameover = true)
        break
      end
    end
  end
end
