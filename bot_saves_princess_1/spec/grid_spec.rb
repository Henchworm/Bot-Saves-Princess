# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/grid'

RSpec.describe Grid do
  context 'initialize' do
    describe '#initialize' do
      let(:valid_rows) { ['---', '-m-', 'p--'] }
      let(:valid_n)    { 3 }
      let(:grid) { Grid.new(valid_n, valid_rows) }

      context 'with valid arguments' do
        it 'stores valid data' do
          expect(grid).to be_a(Grid)
          expect(grid.rows).to eq(valid_rows)
          expect(grid.n).to eq(valid_n)
        end

        it 'does not raise an error' do
          expect { Grid.new(valid_n, valid_rows) }.not_to raise_error
        end
      end

      context 'with invalid arguments' do
        let(:invalid_row_length) { ['---', '-m-', 'p--', '---'] }
        let(:invalid_row_type) { '---, -m-, p--, ---' }
        let(:invalid_row_chars) { [1, 2, 3] }
        let(:invalid_row_consistency) { ['---', '-m-', 'p-'] }

        let(:invalid_n) { 4 }

        it 'raises GridError when n is even' do
          expect do
            Grid.new(invalid_n, valid_rows)
          end.to raise_error(Grid::GridError, "N must be odd: received #{invalid_n}")
        end

        it 'raises GridError when rows count does not equal n' do
          expect do
            Grid.new(valid_n, invalid_row_length)
          end.to raise_error(Grid::GridError, "Rows must be an array of length #{valid_n}")
        end

        it 'raises GridError when row is not an array' do
          expect do
            Grid.new(valid_n, invalid_row_type)
          end.to raise_error(Grid::GridError, "Rows must be an array of length #{valid_n}")
        end

        it 'raises GridError when row array is not strings' do
          expect do
            Grid.new(valid_n, invalid_row_chars)
          end.to raise_error(Grid::GridError, "Row must be a String of length #{valid_n} chars.")
        end

        it 'raises ArgumentError when a row length is not n' do
          expect do
            Grid.new(valid_n, invalid_row_consistency)
          end.to raise_error(Grid::GridError, "Row must be a String of length #{valid_n} chars.")
        end
      end
    end
  end

  context 'methods' do
    let(:valid_rows) { ['---', '-m-', 'p--'] }
    let(:valid_n)    { 3 }
    let(:grid) { Grid.new(valid_n, valid_rows) }

    describe '#center' do
      context 'on a 3x3 grid' do
        it 'creates a position object tracking the center coordinates' do
          position = grid.center
          expect(position).to be_a Position
          expect(position.row).to eq(1)
          expect(position.column).to eq(1)
        end
      end
    end

    describe '#corners' do
      it 'creates a hash of corner position objects tracking corner coordinates' do
        corners = grid.corners

        expect(corners).to be_a(Hash)

        expect(corners[:top_left]).to be_a Position
        expect(corners[:top_left].column).to eq(0)
        expect(corners[:top_left].row).to eq(0)

        expect(corners[:top_right]).to be_a Position
        expect(corners[:top_right].column).to eq(2)
        expect(corners[:top_right].row).to eq(0)

        expect(corners[:bottom_left]).to be_a Position
        expect(corners[:bottom_left].column).to eq(0)
        expect(corners[:bottom_left].row).to eq(2)

        expect(corners[:bottom_right]).to be_a Position
        expect(corners[:bottom_right].column).to eq(2)
        expect(corners[:bottom_right].row).to eq(2)
      end
    end

    describe '#character_at' do
      it 'returns the character at specified coordinates' do
        expect(grid.character_at(1, 1)).to eq('m')
        expect(grid.character_at(2, 0)).to eq('p')
      end
    end

    describe '#find' do
      it 'returns the position of the character we are looking for' do
        mario_position = grid.find_character('m')
        peach_position = grid.find_character('p')

        expect(mario_position).to be_a Position
        expect(mario_position.row).to eq(1)
        expect(mario_position.column).to eq(1)

        expect(peach_position).to be_a Position
        expect(peach_position.row).to eq(2)
        expect(peach_position.column).to eq(0)
      end
    end
  end
end
