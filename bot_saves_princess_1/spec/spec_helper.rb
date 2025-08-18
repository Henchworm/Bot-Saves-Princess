# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/coverage/'
  add_filter '/bin/'
  add_filter '/lib/runner'
end
