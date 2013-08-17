require "bundler/setup"
require "minitest/autorun"
require "rack/test"

$:.unshift File.expand_path("../../lib", __FILE__)

require "polybius"
