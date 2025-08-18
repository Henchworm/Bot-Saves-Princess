# spec/gameplay_spec.rb
# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/gameplay'
require_relative '../lib/bot'
require_relative '../lib/position'
require_relative '../lib/grid'
require_relative '../lib/gridbuilder'
require_relative '../lib/gameformatter'

RSpec.describe GamePlay do
  let(:gameplay) { GamePlay.new }

  before do
    allow(GameFormatter).to receive(:print_intro)
    allow(GameFormatter).to receive(:print_grid)
    allow(GameFormatter).to receive(:print_positions)
    allow(GameFormatter).to receive(:print_path)
    allow(GameFormatter).to receive(:print_success)
    allow(GameFormatter).to receive(:prompt_input)
    allow(GameFormatter).to receive(:print_input_error)
    allow(GameFormatter).to receive(:print_grid_error)
    allow(gameplay).to receive(:sleep)

    allow(GridBuilder).to receive(:princess_coordinates).and_return([0, 0])
  end

  describe '#play' do
    it 'runs the game from input to success message' do
      allow(gameplay).to receive(:gets).and_return('5')

      expect(GameFormatter).to receive(:print_intro)
      expect(GameFormatter).to receive(:prompt_input)
      expect(GameFormatter).to receive(:print_grid)
      expect(GameFormatter).to receive(:print_positions)
      expect(GameFormatter).to receive(:print_path)
      expect(GameFormatter).to receive(:print_success)

      gameplay.play
    end

    context 'errors' do
      it 'handles invalid input and retries until valid' do
        allow(gameplay).to receive(:gets).and_return('', 'abc', '5')

        expect(GameFormatter).to receive(:print_input_error).twice
        expect(GameFormatter).to receive(:prompt_input).exactly(3).times

        gameplay.play
      end
    end

    it 'raises GameError through #validate_input and retriesuntil valid number is provided' do
      allow(GameFormatter).to receive(:prompt_input)
      allow(GameFormatter).to receive(:print_input_error)

      # First input invalid ('abc'), second input valid ('5')
      allow(gameplay).to receive(:gets).and_return('abc', '5')

      expect(GameFormatter).to receive(:print_input_error).with('Input must be a number')
      expect(gameplay.send(:validate_input)).to eq(5)
    end

    it 'prints grid error and retries until valid grid is built' do
      # this is the most complicated test of the bunch: simulating gameplay all the way to
      # raising a GridError. The conditions to raise a GridError are deeply nested,
      # and I wanted to avoid using Ruby's tempting but dangerous'.send' method.
      allow(GameFormatter).to receive(:prompt_input)
      allow(GameFormatter).to receive(:print_input_error)
      allow(GameFormatter).to receive(:print_grid_error)

      allow(gameplay).to receive(:gets).and_return('4', '5')

      bad_n = 4
      good_n = 5

      # First attempt at play: raise GridError
      expect(GridBuilder).to receive(:build).with(bad_n).and_raise(Grid::GridError, 'N must be odd: received 4')

      # Second attempt: return a grid double with expected methods
      grid_double = instance_double('Grid',
                                    rows: ['-----', '--m--', '-----', '--p--', '-----'],
                                    find_character: nil)
      expect(GridBuilder).to receive(:build).with(good_n).and_return(grid_double)

      expect(GameFormatter).to receive(:print_grid_error).with('N must be odd: received 4')

      # stub pathing methods so #play completes
      allow(Bot).to receive(:new).and_return(double('Bot', path_to: %w[UP LEFT]))

      gameplay.play
    end
  end
end
