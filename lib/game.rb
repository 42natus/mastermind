# frozen_string_literal: true

require_relative 'game/board'
require_relative 'game/human_player'
require_relative 'game/human_player/code_breaker'
require_relative 'game/human_player/code_maker'
# require_relative 'game/computer_player'
require_relative 'game/computer_player/code_maker'
require_relative 'game/computer_player/code_breaker'

# This controls gameplay for a full round of the game
class Game
  def initialize
    @board = Board.new
    @code_maker, @code_breaker = assign_roles(HumanPlayer.choose, @board)
  end

  def assign_roles(choice, board)
    return [ComputerPlayer::CodeMaker.new, HumanPlayer::CodeBreaker.new(board)] if
    choice == '1'

    [HumanPlayer::CodeMaker.new, ComputerPlayer::CodeBreaker.new(board)]
  end

  def human_play_round
    12.times do
      @board.display

      @code_breaker.guess

      @code_maker.give_feedback(@board)

      next unless @board.feedbacks.last.eql?(%w[x x x x])

      @code_breaker.correct_guess = true

      break
    end
  end

  def computer_play_round
    12.times do
      @code_breaker.guess

      @board.display(show_code: true)

      @code_maker.give_feedback(@board)

      next unless @board.feedbacks.last.eql?(%w[x x x x])

      @code_breaker.correct_guess = true

      break
    end
  end

  def gameover_msg(player)
    if player.to_s == 'human' && player.correct_guess
      return "\nBravo! You cracked the code!"
    elsif player.to_s == 'human' && !player.correct_guess
      return "\nBetter luck next time..."
    elsif player.to_s == 'computer' && player.correct_guess
      return "\nThe computer cracked it! Better luck next time..."
    end

    "\nYou beat the computer. Bravo!"
  end

  def play
    @board.display if @code_breaker.to_s == 'computer'

    @code_maker.place_code(@board)

    computer_play_round if @code_breaker.to_s == 'computer'

    human_play_round if @code_breaker.to_s == 'human'

    @board.display(show_code: true)

    puts gameover_msg(@code_breaker)
  end
end
