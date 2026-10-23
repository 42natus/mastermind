# frozen_string_literal: true

require_relative '../verifiable'

module Human
  # The code maker uses a combination of 4 of the pegs available to set a code
  class CodeMaker
    include Verifiable

    def sanitize(string)
      string.include?(' ') ? string.split : string.chars
    end

    def place_code(board)
      code = []

      until valid_code?(code)
        print 'Enter your code: '

        code = sanitize(gets.chomp)
      end

      board.store_code(code)
    end

    def give_feedback(board)
      feedback = []

      guess = board.guesses.last.clone

      code = board.code.clone

      until valid_feedback?(feedback, guess, code)
        print 'Give feedback: '

        feedback = sanitize(gets.chomp)
      end

      board.store_feedback(feedback)
    end
  end
end
