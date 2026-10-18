# frozen_string_literal: true

require_relative 'game/board'
require_relative 'game/human_player'
require_relative 'game/human_player/code_breaker'
# require_relative 'game/human_player/code_maker'
# require_relative 'game/computer_player'
require_relative 'game/computer_player/code_maker'
# require_relative 'game/computer_player/code_breaker'

# This controls gameplay for a full round of the game
class Game
  def initialize
    @board = Board.new
    @code_maker, @code_breaker = assign_roles(HumanPlayer.choose)
  end

  def assign_roles(choice)
    [ComputerPlayer::CodeMaker.new, HumanPlayer::CodeBreaker.new] if
    choice == '1'

    # [HumanPlayer::CodeMaker.new, ComputerPlayer::CodeBreaker.new]
  end

  def play_round
    12.times do
      @board.display

      @code_breaker.guess(@board)

      @code_maker.give_feedback(@board)

      next unless @board.feedbacks.last.eql?(%w[x x x x])

      @code_breaker.correct_guess = true

      break
    end
  end

  def computer_gameover_message(correct_guess)
    return "\nBetter luck next time..." if correct_guess

    "\nYou actually outsmarted the computer. Bravo!"
  end

  def human_gameover_message(correct_guess)
    return "\nBRAVO! YOU GOT IT!!" if correct_guess

    "\nBetter luck next time..."
  end

  def play
    @code_maker.place_code(@board)

    play_round

    @board.display(gameover: true)

    puts human_gameover_message(@code_breaker.correct_guess) if
    @code_breaker.to_s == 'human'

    puts computer_gameover_message(@code_breaker.correct_guess) if
    @code_breaker.to_s == 'computer'
  end
end
