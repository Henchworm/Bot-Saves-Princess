# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/gridbuilder'
require_relative '../lib/grid'

RSpec.describe GridBuilder do
  describe '.build' do
    it 'builds a square grid with m(bot) at the center and p(princess) at expected position' do
      # stub out princess spawn randomization for testing purposes
      allow(GridBuilder).to receive(:princess_coordinates).and_return([0, 0])

      grid = GridBuilder.build(5)

      expect(grid).to be_a(Grid)
      expect(grid.rows.length).to eq(5)
      expect(grid.rows.all? { |row| row.length == 5 }).to be true

      expect(grid.character_at(2, 2)).to eq('m')  # bot always centered.
      expect(grid.character_at(0, 0)).to eq('p')  # Princess top-left, as the stub specified
    end

    it 'produces a grid with only one bot and one princess' do
      allow(GridBuilder).to receive(:princess_coordinates).and_return([4, 4])

      grid = GridBuilder.build(5)
      joined = grid.rows.join

      expect(joined.count('m')).to eq(1)
      expect(joined.count('p')).to eq(1)
    end
  end

  describe '.replace_char' do
    it 'replaces a character at a specific index' do
      result = GridBuilder.replace_char('abcde', 2, 'X')
      expect(result).to eq('abXde')
    end
  end

  describe '.princess_coordinates' do
    it 'returns one of the four corners' do
      n = 5
      20.times do
        expect([
                 [0, 0],
                 [0, n - 1],
                 [n - 1, 0],
                 [n - 1, n - 1]
               ]).to include(GridBuilder.princess_coordinates(n))
      end
    end
  end
end
