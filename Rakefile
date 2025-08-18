# frozen_string_literal: true

desc 'Run all specs for Bot Saves Princess 1'
task :spec1 do
  Dir.chdir('bot_saves_princess_1') do
    sh 'bundle exec rspec spec'
  end
end

desc 'Run all specs for Bot Saves Princess 2'
task :spec2 do
  Dir.chdir('bot_saves_princess_2') do
    sh 'bundle exec rspec spec'
  end
end

desc 'Run all specs for both Princess 1 and 2'
task spec_all: %i[spec1 spec2]

desc 'Run RuboCop'
task :rubocop do
  sh 'bundle exec rubocop -c .rubocop.yml', verbose: false
end

desc 'Run linter and all specs'
task default: %i[spec_all rubocop]
