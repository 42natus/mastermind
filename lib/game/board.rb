# frozen_string_literal: true

# This is the board upon which the game will be played. The codemaker sets the
# code and the codebreaker makes guesses on this board.
class Board
  attr_reader :pegs, :code, :guesses, :feedbacks

  def initialize
    @pegs = %w[1 2 3 4 5 6]

    @code = []
    @guesses = []
    @feedbacks = []
  end

  def store_code(pegs)
    @code = pegs
  end

  def store_guess(pegs)
    @guesses << pegs
  end

  def store_feedback(pegs)
    @feedbacks << pegs
  end

  def print_guess(guess)
    print '| '

    guess.each { |peg| print "#{peg} " }

    print '|'
  end

  def print_feedback(feedback)
    # a slot in the feedback area with no peg is denoted by '_'
    feedback.fill('_', feedback.length, 4 - feedback.length)

    feedback = feedback.shuffle

    print ' ( '

    feedback.each { |peg| print "#{peg} " }

    print ')'
  end

  def print_pegs
    (0...@guesses.length).each do |i|
      print_guess(@guesses[i])

      print_feedback(@feedbacks[i])

      puts ''
    end
  end

  def print_blanks(number)
    number.times { puts '| _ _ _ _ | ( _ _ _ _ )' }
  end

  def reveal_code
    print '[ '

    code.each { |peg| print "#{peg} " }

    print "]\n"
  end

  def display(gameover: false)
    puts "\n----- MASTERMIND -----"

    print_pegs

    print_blanks(12 - @guesses.length)

    if gameover
      reveal_code
    else
      puts '[ # # # # ]'
    end
  end
end
