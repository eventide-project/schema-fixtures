require_relative '../interactive_init'

context "Assignment" do
  context "List" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random

    fixture(Assignment, schema, [:some_attribute])
  end
end
