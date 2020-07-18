require_relative '../../automated_init'

context "Equality" do
  context "Title" do
    context "Not Printed" do
      control = Controls::Schema.example
      compare = Controls::Schema.example

      fixture = Equality.build(control, compare, print_title: false)
      fixture.()

      context "Schema Equality Context" do
        printed = fixture.test_session.context?("Schema Equality: Example, Example")

        test "Not Printed" do
          refute(printed)
        end
      end
    end
  end
end
