# frozen_string_literal: true

require_relative 'position'

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

# The Grid class represents an n x n square grid - and the base functionality is nearly identical to iteration 1.
# Since version 2 provides the grid, I removed the validation and error handling.

# A Grid knows its size (n), its rows of characters, and provides
# helper methods for locating and working with positions - creating position objects.
# Grid Responsibilities:
# - Store the grid’s rows as strings (each of length n).
# - Allow lookup of characters at specific row/column positions.
# - Find the coordinates of character 'm' or 'p'.
