require_relative '../interactive_init'

context "Equality" do
  context "Map" do
    control = Schema::Controls::Schema.example
    compare = Schema::Controls::Schema::Equivalent.example

    map = [
      :some_attribute,
      { :some_other_attribute => :yet_another_attribute }
    ]

    fixture(Equality, control, compare, map)
  end
end
