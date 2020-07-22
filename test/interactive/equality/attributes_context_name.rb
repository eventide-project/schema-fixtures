require_relative '../interactive_init'

context "Equality" do
  context "Attributes Context Name" do
    control = Controls::Schema.example
    compare = Controls::Schema.example

    fixture(Equality, control, compare, attributes_context_name: 'Other Attributes Context Name')
  end
end
