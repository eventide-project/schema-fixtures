require_relative '../../automated_init'

context "Equality" do
  context "Title" do
    context "Printed" do
      control = Controls::Schema.example
      compare = Controls::Schema.example

      fixture = Equality.build(control, compare)
      fixture.()

      context "Schema Equality Context" do
        printed = fixture.test_session.context?("Schema Equality: Example, Example")

        test "Printed" do
          assert(printed)
        end
      end
    end
  end
end
