# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/bot'
require_relative '../lib/position'

RSpec.describe Bot do
  let(:starting_position) { Position.new(1, 1) }
  let(:bot) { Bot.new(starting_position) }

  context 'initialize' do
    describe '#initialize' do
      context 'with a valid Position' do
        it 'stores the starting position' do
          expect(bot).to be_a(Bot)
          expect(bot.position).to be_a(Position)
          expect(bot.position.row).to eq(1)
          expect(bot.position.column).to eq(1)
        end
      end
    end

    context 'methods' do
      describe '#step_toward' do
        context 'when target is below the bot' do
          let(:target) { Position.new(3, 1) }

          it 'moves down one cell and updates position' do
            move = bot.step_toward(target)
            expect(move).to eq('DOWN')
            expect(bot.position.row).to eq(2)
            expect(bot.position.column).to eq(1)
          end
        end

        context 'when target is above the bot' do
          let(:target) { Position.new(0, 1) }

          it 'moves UP one cell and updates position' do
            move = bot.step_toward(target)
            expect(move).to eq('UP')
            expect(bot.position.row).to eq(0)
            expect(bot.position.column).to eq(1)
          end
        end

        context 'when rows match and target is to the right' do
          let(:target) { Position.new(1, 3) }

          it 'moves right one cell and updates position' do
            move = bot.step_toward(target)
            expect(move).to eq('RIGHT')
            expect(bot.position.row).to eq(1)
            expect(bot.position.column).to eq(2) # 1 -> 2
          end
        end

        context 'when rows match and target is to the left' do
          let(:target) { Position.new(1, 0) }

          it 'moves left one cell and updates position' do
            move = bot.step_toward(target)
            expect(move).to eq('LEFT')
            expect(bot.position.row).to eq(1)
            expect(bot.position.column).to eq(0)
          end
        end

        context 'move ordering (vertical before horizontal)' do
          let(:target) { Position.new(2, 0) }

          it 'prefers vertical move when not aligned on rows' do
            first = bot.step_toward(target)
            expect(first).to eq('DOWN')
            second = bot.step_toward(target)
            expect(second).to eq('LEFT')
          end
        end
      end
    end
  end
end
