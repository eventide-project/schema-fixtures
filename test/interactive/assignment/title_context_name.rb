require_relative '../interactive_init'

context "Assignment" do
  context "Title Context Name" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random
    schema.some_other_attribute = Controls::Attribute::Value.random

    fixture(Assignment, schema, title_context_name: 'Other Context Name')
  end
end
