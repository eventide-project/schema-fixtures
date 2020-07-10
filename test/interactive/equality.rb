require_relative 'interactive_init'

context "Equality" do
    control = Controls::Schema.example
    compare = Controls::Schema.other_example

    # compare = Controls::Schema::Equivalent.example
    # compare.yet_another_attribute = Controls::Attribute::Value.random

    fixture = fixture(Equality, control, compare)
end
