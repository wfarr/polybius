$:.unshift File.expand_path("../lib", __FILE__)

require "polybius/app"

$stdout.sync = true

run Polybius::App
