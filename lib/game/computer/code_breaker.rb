# frozen_string_literal: true

require_relative '../verifiable'

module Computer
  # The program uses the Swaszek (1999–2000) algorithm to deduce the code set by
  # the code maker
  class CodeBreaker
    include Verifiable

    attr_accessor :correct_guess

    def initialize(board)
      @board = board
      @candidates = @board.pegs.repeated_permutation(4).to_a
      @correct_guess = false
    end

    def to_s
      'computer'
    end

    def eliminate_candidates
      feedback = @board.feedbacks.last
      guess = @board.guesses.last

      @candidates = @candidates.select do |candidate|
        check_pegs(candidate, guess).sort == feedback.sort
      end
    end

    def guess
      eliminate_candidates if @board.feedbacks.any?

      if @board.guesses.any?
        idx = (rand * @candidates.size).floor
        @board.store_guess(@candidates[idx])
        # copy last candidate into used position then remove last candidate
        @candidates[idx] = @candidates.pop
      end

      @board.store_guess(%w[1 1 2 2]) if @board.guesses.empty?
    end
  end
end
