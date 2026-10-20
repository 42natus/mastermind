# frozen_string_literal: true

# require 'pry-byebug'
require_relative '../verifiable'

module ComputerPlayer
  # The computer as the code breaker uses some algorithm to eventually deduce
  # the code set by the code maker
  class CodeBreaker
    include Verifiable

    attr_accessor :correct_guess

    def initialize(board)
      @correct_guess = false
      @candidates = []
      board.pegs.repeated_permutation(4) { |candidate| @candidates << candidate }
    end

    def to_s
      'computer'
    end

    def eliminate_candidates(feedback, code)
      feedback.delete_if { |ch| ch == '_' }

      @candidates = @candidates.select do |candidate|
        check_pegs(candidate, code) == feedback
      end

      @candidates
    end

    def guess(board)
      feedback = board.feedbacks.last
      guess = board.guesses.last

      eliminate_candidates(feedback, guess) if board.feedbacks.any?

      idx = (rand * @candidates.size).floor

      unless board.guesses.empty?
        board.store_guess(@candidates[idx])
        @candidates[idx] = @candidates.last
        @candidates.pop
      end

      board.store_guess(%w[1 1 2 2]) if board.guesses.empty?

      board.display
    end
  end
end
