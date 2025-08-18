# frozen_string_literal: true

require_relative 'grid'

class GridBuilder
  def self.build(n)
    rows = Array.new(n) { '-' * n }

    mid = n / 2
    rows[mid] = replace_char(rows[mid], mid, 'm')

    r, c = princess_coordinates(n)
    rows[r] = replace_char(rows[r], c, 'p')

    Grid.new(n, rows)
  end

  def self.replace_char(str, index, ch)
    str.dup.tap { _1[index] = ch }
  end

  def self.princess_coordinates(n)
    [
      [0, 0],
      [0, n - 1],
      [n - 1, 0],
      [n - 1, n - 1]
    ].sample
  end
end

# GridBuilder is a factory pattern class used to work out some minor details before
# building a Grid object that will be used in gameplay: replacing string chars, randomizing
# the princess, and placing the bot in the middle. It contains zero behavioral logic about
# how to interpret or query the instance of 'Grid' it creates - this class is purely a builder.
