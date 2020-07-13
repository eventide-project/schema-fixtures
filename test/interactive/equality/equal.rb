require_relative '../interactive_init'

context "Equality" do
  context "Equal" do
    control = Controls::Schema.example
    compare = Controls::Schema.example

    fixture(Equality, control, compare)
  end
end
