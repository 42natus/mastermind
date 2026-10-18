# frozen_string_literal: true

# This module contains methods that check/validate some data
module Verifiable
  def valid_code?(code)
    return false if code.any? { |peg| !%w[1 2 3 4 5 6].include?(peg) }

    # must use 4 integers
    code = code.join

    code.length == 4 && code.length == code.to_i.to_s.length
  end

  def correct_position(pegs, code)
    feedback = []

    # check if each peg's in the code AND in the correct position
    pegs.each_with_index do |peg, position|
      next unless code[position] == peg

      feedback.push('x')
      # value ignorable cos it's been assessed — won't affect next check
      code[position] = '_'
    end

    feedback
  end

  def wrong_position(pegs, code)
    feedback = []

    # any pegs present in the code after last check are in the wrong position
    pegs.each do |peg|
      if code.include?(peg)
        feedback.push('o')
        code[code.index(peg)] = '_'
      end
    end

    feedback
  end

  def check_pegs(pegs, code)
    feedback = []

    feedback.push(correct_position(pegs, code))

    feedback.push(wrong_position(pegs, code))

    feedback.flatten
  end

  def valid_feedback?(board, feedback)
    last_guess = board.guesses[-1]

    code = board.code.clone

    check_pegs(last_guess, code).sort == feedback.sort
  end
end
