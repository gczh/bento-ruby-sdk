$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

# Must be at top of file
require "simplecov"
require 'simplecov-cobertura'

SimpleCov.start
SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter

# Other
require "bento-sdk"
require 'faraday'
require "pry"