# frozen_string_literal: true

require_relative 'game/board'
require_relative 'game/human'
require_relative 'game/human/code_breaker'
require_relative 'game/human/code_maker'
require_relative 'game/computer/code_maker'
require_relative 'game/computer/code_breaker'

# This controls gameplay for a full round of the game
class Game
  def initialize
    @board = Board.new
    @code_maker, @code_breaker = assign_roles(Human.choose)
  end

  def assign_roles(choice)
    return [Computer::CodeMaker.new, Human::CodeBreaker.new(@board)] if
    choice == '1'

    [Human::CodeMaker.new, Computer::CodeBreaker.new(@board)]
  end

  def guessed_right?
    @board.feedbacks.last.eql?(%w[x x x x])
  end

  def play_round_with_human
    12.times do
      @board.display

      @code_breaker.guess

      @code_maker.give_feedback(@board)

      next unless guessed_right?

      @code_breaker.correct_guess = true

      break
    end
  end

  def play_round_with_computer
    12.times do
      @code_breaker.guess

      @board.display(show_code: true)

      @code_maker.give_feedback(@board)

      next unless guessed_right?

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

    play_round_with_computer if @code_breaker.to_s == 'computer'

    play_round_with_human if @code_breaker.to_s == 'human'

    @board.display(show_code: true)

    puts gameover_msg(@code_breaker)
  end
end
