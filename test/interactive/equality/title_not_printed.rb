require_relative '../interactive_init'

context "Equality" do
  context "Title Not Printed" do
    control = Controls::Schema.example
    compare = Controls::Schema.example

    fixture(Equality, control, compare, print_title_context: false)
  end
end
