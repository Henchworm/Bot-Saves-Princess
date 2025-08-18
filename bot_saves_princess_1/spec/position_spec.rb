# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/position'

RSpec.describe Position do
  let!(:position1) { Position.new(1, 2) }
  let!(:position2) { Position.new(1, 2) }
  let!(:different_position_row) { Position.new(3, 1) }
  let!(:different_position_column) { Position.new(1, 3) }

  describe '#initialize' do
    context 'with valid arguments' do
      it 'initializes and stores row and column' do
        expect(position1).to be_a(Position)
        expect(position1.row).to eq(1)
        expect(position1.column).to eq(2)
      end
    end

    context 'methods' do
      describe '#same_position?' do
        context 'when two positions have the same coordinates' do
          it 'returns true' do
            expect(position1.same_position?(position2)).to be true
          end
        end

        context 'when positions differ' do
          it 'returns false for different rows' do
            expect(position1.same_position?(different_position_row)).to be false
          end

          it 'returns false for different columnss' do
            expect(position1.same_position?(different_position_column)).to be false
          end
        end
      end
    end
  end
end
