require_relative '../interactive_init'

context "Equality" do
  context "Attributes Context Name" do
    control = Controls::Schema.example
    compare = Controls::Schema.example

    fixture(Equality, control, compare, title_context_name: 'Other Context Name')
  end
end
