require_relative '../interactive_init'

context "Assignment" do
  context "Title Not Printed" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random
    schema.some_other_attribute = Controls::Attribute::Value.random

    fixture(Assignment, schema, print_title_context: false)
  end
end
