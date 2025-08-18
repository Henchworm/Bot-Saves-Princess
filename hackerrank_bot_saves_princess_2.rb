# frozen_string_literal: true

class Position
  attr_reader :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def same_position?(other)
    row == other.row && column == other.column
  end
end

class Grid
  attr_reader :n, :rows

  def initialize(n, rows)
    @n    = n
    @rows = rows
  end

  def character_at(row, column)
    rows[row][column]
  end

  def find_character(character)
    rows.each_with_index.map do |line, row|
      col = line.index(character)
      Position.new(row, col) if col
    end.compact.first
  end
end

class Bot
  attr_reader :position

  def initialize(position)
    @position = position
  end

  def step_toward(target)
    if position.row > target.row
      @position = Position.new(position.row - 1, position.column)
      'UP'
    elsif position.row < target.row
      @position = Position.new(position.row + 1, position.column)
      'DOWN'
    elsif position.column > target.column
      @position = Position.new(position.row, position.column - 1)
      'LEFT'
    elsif position.column < target.column
      @position = Position.new(position.row, position.column + 1)
      'RIGHT'
    end
  end
end

def nextMove(n, r, c, grid)
  grid_obj = Grid.new(n, grid)
  bot_position = Position.new(r, c)
  princess_position = grid_obj.find_character('p')
  bot = Bot.new(bot_position)

  puts bot.step_toward(princess_position)
end

n = gets.to_i
r, c = gets.strip.split.map(&:to_i)
grid = Array.new(n) { gets.strip }

nextMove(n, r, c, grid)
