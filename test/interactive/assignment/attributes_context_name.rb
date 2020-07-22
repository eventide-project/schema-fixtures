require_relative '../interactive_init'

context "Assignment" do
  context "Attributes Context Name" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random
    schema.some_other_attribute = Controls::Attribute::Value.random

    fixture(Assignment, schema, attributes_context_name: 'Other Attributes Context Name')
  end
end
