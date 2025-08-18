# frozen_string_literal: true

require_relative '../lib/gameplay'

RSpec.describe GamePlay do
  describe '#play' do
    it 'prints only the final move line' do
      game = GamePlay.new

      allow(game).to receive(:gets).and_return(
        "5\n",
        "-----\n",
        "--p--\n",
        "-----\n",
        "-----\n",
        "--m--\n"
      )

      # Suppress puts from muddying up the tests
      allow(game).to receive(:puts).with(/Enter/)
      allow(game).to receive(:print)

      # use a spy + regex on `puts` and track only calls that match "Next move:"
      expect(game).to receive(:puts).with(/Next move: (UP|DOWN|LEFT|RIGHT)/)

      game.play
    end
  end
end
