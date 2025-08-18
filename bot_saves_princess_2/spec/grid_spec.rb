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
      end
    end
  end

  context 'methods' do
    let(:valid_rows) { ['---', '-m-', 'p--'] }
    let(:valid_n)    { 3 }
    let(:grid) { Grid.new(valid_n, valid_rows) }

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
