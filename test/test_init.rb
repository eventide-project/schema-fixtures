puts RUBY_DESCRIPTION

puts
puts "TEST_BENCH_DETAIL: #{ENV['TEST_BENCH_DETAIL'].inspect}"
puts

require_relative '../init.rb'
require 'schema/fixtures/controls'

require 'pp'

require 'test_bench'; TestBench.activate

include Schema::Fixtures
