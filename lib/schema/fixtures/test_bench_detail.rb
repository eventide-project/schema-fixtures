module TestBench
  module Fixture
    def detail(text)
      detail = TestBench::Environment::Boolean.fetch('TEST_BENCH_DETAIL', false)
      if detail
        comment(text)
      end
    end
  end
end
