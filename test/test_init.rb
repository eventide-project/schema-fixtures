puts RUBY_DESCRIPTION

puts
puts "TEST_BENCH_VERBOSE: #{ENV['TEST_BENCH_VERBOSE'].inspect}"
puts

require_relative '../init.rb'
require 'schema/fixtures/controls'

require 'pp'

require 'test_bench'; TestBench.activate

include Schema::Fixtures
