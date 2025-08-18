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
end

# Just like in version 1 The Bot class is initialized with a starting position, then marches relentlessly towards the princess,
# leaving a trail of position objects.
# Move ONE step toward the target position - Princess's location(not necesarrily a corner this time around.
# Updates @position by one cell as the bot gets closer to track current position.
# Returns the move string: "UP" | "DOWN" | "LEFT" | "RIGHT".
# I removed the method #path_to since the version 2 challenge only requires a single next move.
