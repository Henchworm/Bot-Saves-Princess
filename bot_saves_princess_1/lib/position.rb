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

# The Position class represents a coordinate on the grid
# using row and column values.
# It provides the method same_position? to compare two positions for equality.
# During gameplay, the Bot and Princess each have a Position.
# When their positions are the same, the Bot has reached the Princess
# and the game is over.
