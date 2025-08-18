# frozen_string_literal: true

require_relative 'position'

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

# The Bot class is initialized with a starting position, then marches relentlessly towards the princess,
# leaving a trail of position objects.
# Move ONE step toward the target position - Princess's corner.
# Returns the move string: "UP" | "DOWN" | "LEFT" | "RIGHT".
# updates @position by one cell as the bot gets closer to track current position.
