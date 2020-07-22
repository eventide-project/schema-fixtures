require_relative '../../automated_init'

context "Assignment" do
  context "Title" do
    context "Printed" do
      schema = Controls::Schema::DefaultValue.example

      schema.some_attribute = Controls::Attribute::Value.random
      schema.some_other_attribute = Controls::Attribute::Value.random

      fixture = Assignment.build(schema)
      fixture.()

      context "Schema Assignment Context" do
        printed = fixture.test_session.context?("Schema Assignment: Example")

        test "Printed" do
          assert(printed)
        end
      end
    end
  end
end
