require_relative '../automated_init'

context "Assignment" do
  context "Attributes Context Name" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random
    schema.some_other_attribute = Controls::Attribute::Value.random

    fixture = Assignment.build(schema, attributes_context_name: 'Other Attributes Context Name')
    fixture.()

    printed = fixture.test_session.context?('Other Attributes Context Name')

    test "Printed" do
      assert(printed)
    end
  end
end
