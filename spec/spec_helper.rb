$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "bento-sdk"
require 'faraday'
require "pry"

require "simplecov"
SimpleCov.start

require 'simplecov-cobertura'
SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter