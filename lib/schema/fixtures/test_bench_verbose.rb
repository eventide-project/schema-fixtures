module TestBench
  module Fixture
    def verbose(message)
      verbose = TestBench::Environment::Boolean.fetch('TEST_BENCH_VERBOSE', false)
      if verbose
        comment(message)
      end
    end
  end
end
