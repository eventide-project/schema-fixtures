require_relative '../../automated_init'

context "Assignment" do
  context "Title" do
    context "Not Printed" do
      schema = Controls::Schema::DefaultValue.example

      schema.some_attribute = Controls::Attribute::Value.random
      schema.some_other_attribute = Controls::Attribute::Value.random

      fixture = Assignment.build(schema, print_title_context: false)
      fixture.()

      context "Schema Assignment Context" do
        printed = fixture.test_session.context?("Schema Assignment: Example")

        test "Not Printed" do
          refute(printed)
        end
      end
    end
  end
end
