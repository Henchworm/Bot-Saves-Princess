# frozen_string_literal: true

desc 'Run all specs for Bot Saves Princess 1'
task :spec1 do
  sh 'bundle exec rspec --pattern "challenges/bot_saves_princess_1/spec/**/*_spec.rb"'
end

desc 'Run RuboCop'
task :rubocop do
  sh 'bundle exec rubocop'
end

task default: %i[rubocop spec1]
