require_relative '../../automated_init'

context "Assignment" do
  context "Title Context Name" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random
    schema.some_other_attribute = Controls::Attribute::Value.random

    fixture = Assignment.build(schema, title_context_name: 'Other Context Name')
    fixture.()

    printed = fixture.test_session.context?('Other Context Name')

    test "Printed" do
      assert(printed)
    end
  end
end
