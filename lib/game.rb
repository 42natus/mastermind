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

    12.times do
      puts ''
      @board.display
      
      @code_breaker.guess(@board)
      
      feedback = @code_maker.give_feedback(@board)
      
      if feedback.nil?
        puts ''
        @board.display(gameover = true)
        puts "\nBRAVO! YOU GOT IT!!"
        return
      end
    end

    puts ''
    @board.display(gameover = true)

    puts "\nBetter luck next time..."
  end
end
