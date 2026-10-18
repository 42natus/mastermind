# frozen_string_literal: true

require_relative '../verifiable'

module ComputerPlayer
  # The computer as the code maker uses a random combination of the pegs
  # available to set a code and gives feedback on the guess of the code breaker.
  class CodeMaker
    include Verifiable

    def place_code(board)
      code = board.pegs.sample(4)

      board.store_code(code)
    end

    def correct_guess?(guess, code)
      guess.eql?(code)
    end

    def give_feedback(board)
      last_guess = board.guesses[-1]

      code = board.code.clone

      if correct_guess?(last_guess, code)
        board.store_feedback(%w[x x x x])
      else
        board.store_feedback(check_pegs(last_guess, code))
      end
    end
  end
end
