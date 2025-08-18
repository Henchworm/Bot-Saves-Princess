# frozen_string_literal: true

require_relative 'position'

class Grid
  class GridError < StandardError; end

  attr_reader :n, :rows

  def initialize(n, rows)
    @n    = n
    @rows = rows
    validate_shape
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

  private

  def validate_shape
    # I first designed this method with the idea that the user would input the grid themselves with '-,p,-, etc:
    # then I thought that would deliver added complexity to the user. Kept the validations for this to keep it
    # flexible for future implementations.
    raise GridError, "N must be odd: received #{n}" unless n.odd?

    raise GridError, "N must be >= 3: received #{n}" if n < 3

    raise GridError, "Rows must be an array of length #{n}" unless rows.is_a?(Array) && rows.length == n

    rows.each do |line|
      raise GridError, "Row must be a String of length #{n} chars." unless line.is_a?(String) && line.length == n
    end
  end
end

# The Grid class represents an n x n square grid.
# A Grid knows its size (n), its rows of characters, and provides
# helper methods for locating and working with positions - creating position objects.
#
# Grid Responsibilities:
# - Store the grid’s rows as strings (each of length n).
# - Validate the grid shape (must be n rows, each exactly n chars, n must be odd - provides custom error handling.
# - Provide quick access to key coordinates (center, corners).
# - Allow lookup of characters at specific row/column positions.
# - Find the coordinates of character 'm' or 'p'.
