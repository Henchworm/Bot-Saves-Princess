# frozen_string_literal: true

require_relative 'grid'
require_relative 'bot'

class GamePlay
  def play
    puts 'Enter grid size (odd number >= 3):'
    n = gets.to_i

    puts "Enter each row of the grid (#{n} total):"
    rows = Array.new(n) do |i|
      print "Row #{i + 1}: "
      gets.chomp
    end

    grid = Grid.new(n, rows)

    bot_position      = grid.find_character('m')
    princess_position = grid.find_character('p')

    bot = Bot.new(bot_position)
    puts "\nNext move: #{bot.step_toward(princess_position)}"
  end
end
