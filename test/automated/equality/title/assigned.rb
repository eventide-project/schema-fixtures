require_relative '../../automated_init'

context "Equality" do
  context "Title" do
    context "Assigned" do
      control = Controls::Schema.example
      compare = Controls::Schema.example

      fixture = Equality.build(control, compare, title_context_name: 'Other Context Name')
      fixture.()

      context "Schema Equality Context" do
        printed = fixture.test_session.context?('Other Context Name')

        test "Printed" do
          assert(printed)
        end
      end
    end
  end
end
