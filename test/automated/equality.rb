require_relative 'automated_init'

context "Equality" do
  context "Not Equal" do
    control = Controls::Schema.example
    compare = Controls::Schema::Equivalent.example

    compare.yet_another_attribute = Controls::Attribute::Value.random

    fixture = Equality.new(control, compare)
    # fixture = TestBench::Fixture.build(Equality, control, compare)
    # fixture = fixture(Equality, control, compare)
    # fixture.()

    context "some_other_attribute" do
      failed = fixture.test_session.test_failed?(':some_other_attribute')

      test "Failed" do
        assert(failed)
      end

      test "Commented" do
        commented = fixture.test_session.commented?('!!')
        assert(commented)
      end
    end
  end
end
