require_relative '../automated_init'

context "Assignment" do
  context "List" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random

    control_name = :some_attribute

    fixture = Assignment.build(schema, [control_name])
    fixture.()

    context "#{control_name}" do
      passed = fixture.test_session.test_passed?(control_name)

      test "Passed" do
        assert(passed)
      end
    end

    context "some_other_attribute" do
      tested = fixture.test_session.test?('some_other_attribute')

      test "Not tested" do
        refute(tested)
      end
    end
  end
end
