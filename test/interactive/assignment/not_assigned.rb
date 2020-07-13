require_relative '../interactive_init'

context "Assignment" do
  context "Not Assigned" do
    schema = Controls::Schema::DefaultValue.example

    fixture(Assignment, schema)
  end
end
