require_relative '../../../automated_init'

context "Equality" do
  context "Attribute List" do
    context "List" do
      context "Equal" do
        control = Controls::Schema.example
        compare = Controls::Schema.example

        control_name = :some_attribute

        list = [control_name]

        fixture = Equality.build(control, compare, list)
        fixture.()

        context control_name.to_s do
          passed = fixture.test_session.test_passed?(control_name.to_s)

          test "Passed" do
            assert(passed)
          end
        end

        context "some_other_attribute" do
          tested = fixture.test_session.test?('some_other_attribute')

          test "Not tested" do
            refute(tested)
          end
        end
      end
    end
  end
end
