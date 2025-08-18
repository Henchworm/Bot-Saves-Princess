# lib/game_formatter.rb
# frozen_string_literal: true

class GameFormatter
  def self.prompt_input
    print 'Enter grid size (any integer; must be odd and >= 3):'
  end

  def self.print_input_error(message)
    puts "Input Error: #{message}"
  end

  def self.print_grid_error(message)
    puts "Grid Error: #{message}"
    puts "Please try again.\n"
  end

  def self.print_grid(rows)
    rows.each { |line| puts line }
  end

  def self.format_pos(pos)
    "(row=#{pos.row}, col=#{pos.column})"
  end

  def self.print_intro
    puts 'Welcome to Bot Saves Princess!'
  end

  def self.print_positions(bot_pos, princess_pos)
    puts "\nBot at #{format_pos(bot_pos)}, Princess at #{format_pos(princess_pos)}"
  end

  def self.print_path(moves)
    puts "\nPath to rescue:"
    moves.each_with_index do |move, i|
      puts "Step #{i + 1}: #{move}"
      sleep(0.25)
    end
  end

  def self.print_success
    puts "\nPrincess saved by our brave and efficient bot!"
  end
end

# GameFormatter is a stateless utility class that
# exists purely to take printing + 'game fun' logic like sleep
# out of the complex Gameplay class for ease of testing.
