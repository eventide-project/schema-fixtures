require_relative '../../../interactive_init'

context "Equality" do
  context "Attribute List" do
    context "Map" do
      context "Equal" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema::Equivalent.example

        control_name = :some_other_attribute
        compare_name = :yet_another_attribute

        map = [
          { control_name => compare_name }
        ]

        fixture(Equality, control, compare, map)
      end
    end
  end
end
