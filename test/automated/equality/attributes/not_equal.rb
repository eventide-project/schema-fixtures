require_relative '../../automated_init'

context "Equality" do
  context "Not Equal" do
    control = Controls::Schema.example
    compare = Controls::Schema.example

    compare.some_other_attribute = Controls::Attribute::Value.random

    fixture = Equality.build(control, compare)
    fixture.()

    context "some_attribute" do
      passed = fixture.test_session.test_passed?('some_attribute')

      test "Passed" do
        assert(passed)
      end
    end

    context "some_other_attribute" do
      passed = fixture.test_session.test_failed?('some_other_attribute')

      test "Failed" do
        assert(passed)
      end
    end
  end
end
