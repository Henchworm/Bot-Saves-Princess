# spec/game_formatter_spec.rb
# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/gameformatter'
require_relative '../lib/position'

RSpec.describe GameFormatter do
  describe '.print_intro' do
    it 'prints the game welcome message' do
      expect { GameFormatter.print_intro }
        .to output("Welcome to Bot Saves Princess!\n").to_stdout
    end
  end

  describe '.print_grid' do
    it 'prints each row on a separate line' do
      expect do
        GameFormatter.print_grid(%w[abc def])
      end.to output("abc\ndef\n").to_stdout
    end
  end

  describe '.format_pos' do
    it 'returns formatted (row=x, col=y) string' do
      pos = Position.new(1, 4)
      expect(GameFormatter.format_pos(pos)).to eq('(row=1, col=4)')
    end
  end

  describe '.print_positions' do
    it 'prints both bot and princess positions' do
      bot_pos = Position.new(1, 1)
      princess_pos = Position.new(0, 4)

      expect do
        GameFormatter.print_positions(bot_pos, princess_pos)
      end.to output("\nBot at (row=1, col=1), Princess at (row=0, col=4)\n").to_stdout
    end
  end

  describe '.print_path' do
    before { allow(GameFormatter).to receive(:sleep) }

    it 'prints each move step on a new line with index' do
      moves = %w[UP LEFT LEFT]
      expect do
        GameFormatter.print_path(moves)
      end.to output(
        "\nPath to rescue:\nStep 1: UP\nStep 2: LEFT\nStep 3: LEFT\n"
      ).to_stdout
    end
  end

  describe '.print_success' do
    it 'prints the success message' do
      expect do
        GameFormatter.print_success
      end.to output("\nPrincess saved by our brave and efficient bot!\n").to_stdout
    end
  end

  context 'errors' do
    describe '.prompt_input' do
      it 'prints a prompt message to the user' do
        expect do
          GameFormatter.prompt_input
        end.to output('Enter grid size (any integer; must be odd and >= 3):').to_stdout
      end
    end

    describe '.print_input_error' do
      it 'prints a formatted input error message' do
        expect { GameFormatter.print_input_error('Not a number') }
          .to output("Input Error: Not a number\n").to_stdout
      end
    end

    describe '.print_grid_error' do
      it 'prints a formatted grid error message and retry message' do
        expect { described_class.print_grid_error('Grid too small') }
          .to output("Grid Error: Grid too small\nPlease try again.\n").to_stdout
      end
    end
  end
end
