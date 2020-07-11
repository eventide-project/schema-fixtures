require_relative '../../../interactive_init'

context "Equality" do
  context "Attribute List" do
    context "List" do
      context "Equal" do
        control = Controls::Schema.example
        compare = Controls::Schema.other_example

        control_name = :some_attribute

        list = [control_name]

        fixture(Equality, control, compare, list)
      end
    end
  end
end
