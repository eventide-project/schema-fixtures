require_relative 'interactive_init'

context "Equality" do
  control = Controls::Schema.example
  compare = Controls::Schema.other_example

  fixture(Equality, control, compare)
end
