# frozen_string_literal: true

# This module defines the methods available to the human player
module HumanPlayer
  def self.choose
    puts 'Hello! You can choose your role below: (1/2)'
    puts '1. Code breaker'
    puts '2. Code maker'

    choice = ''

    until %w[1 2].include?(choice)
      print 'Enter your choice: '
      choice = gets.chomp
    end

    choice
  end
end
