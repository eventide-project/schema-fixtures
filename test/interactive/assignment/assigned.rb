require_relative '../interactive_init'

context "Assignment" do
  context "Assigned" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random
    schema.some_other_attribute = Controls::Attribute::Value.random

    fixture(Assignment, schema)
  end
end
