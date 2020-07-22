require_relative '../automated_init'

context "Equality" do
  context "Attributes Context Name" do
    control = Controls::Schema.example
    compare = Controls::Schema.example

    fixture = Equality.build(control, compare, attributes_context_name: 'Other Attributes Context Name')
    fixture.()

    printed = fixture.test_session.context?('Other Attributes Context Name')

    test "Printed" do
      assert(printed)
    end
  end
end
