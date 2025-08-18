# runner.rb
# frozen_string_literal: true

require_relative 'gameplay'
GamePlay.new.play if __FILE__ == $PROGRAM_NAME
