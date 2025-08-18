# challenges/bot_saves_princess_1/lib/gameplay.rb
# frozen_string_literal: true

require_relative 'grid'
require_relative 'bot'
require_relative 'position'
require_relative 'gameformatter'
require_relative 'gridbuilder'

class GamePlay
  class GameError < StandardError; end

  def play
    GameFormatter.print_intro
    grid = build_grid

    bot_position      = grid.find_character('m') 
    princess_position = grid.find_character('p')

    GameFormatter.print_grid(grid.rows)
    GameFormatter.print_positions(bot_position, princess_position)

    bot   = Bot.new(bot_position)
    moves = bot.path_to(princess_position)

    GameFormatter.print_path(moves)
    GameFormatter.print_success
  end

  private

  def validate_input
    # originally had this as a loop, but it became too complicated to stub out the results.
    # changed to a recursive strategy for both validate_input and build_grid.
    GameFormatter.prompt_input
    raw = gets.chomp
    parse_input(raw)
  rescue GameError => e
    GameFormatter.print_input_error(e.message)
    validate_input
  end

  def parse_input(raw)
    raise GameError, 'Input cannot be empty' if raw.nil?
    raise GameError, 'Input must be a number' unless raw.match?(/^\d+$/)

    raw.to_i
  end

  def build_grid
    n = validate_input
    GridBuilder.build(n)
  rescue Grid::GridError => e
    GameFormatter.print_grid_error(e.message)
    build_grid
  end
end
