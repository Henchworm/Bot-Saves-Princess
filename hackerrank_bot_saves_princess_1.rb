# frozen_string_literal: true

#HackerRank submission for 'Bot Saves Princess' with heavy OOP/Rubyism focus. 
#Removed all custom error handling, user input validation, builder classes and helpers that exist in bot_saves_princess_1 directory. 

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

  def center
    middle = n / 2
    Position.new(middle, middle)
  end

  def corners
    last = n - 1
    {
      top_left: Position.new(0, 0),
      top_right: Position.new(0, last),
      bottom_left: Position.new(last, 0),
      bottom_right: Position.new(last, last)
    }
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

  def path_to(target)
    moves = []
    moves << step_toward(target) until position.same_position?(target)
    moves
  end
end

def displayPathtoPrincess(n, rows)
  grid = Grid.new(n, rows)
  bot_position = grid.find_character('m')
  princess_position = grid.find_character('p')
  bot = Bot.new(bot_position)

  bot.path_to(princess_position).each do |move|
    puts move
  end
end

  if __FILE__ == $PROGRAM_NAME
    n = gets.to_i
    grid = Array.new(n) { gets.chomp }
    displayPathtoPrincess(n, grid)
  end