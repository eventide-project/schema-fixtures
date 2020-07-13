require_relative '../../../automated_init'

context "Equality" do
  context "Attribute List" do
    context "List" do
      context "Not Equal" do
        control = Controls::Schema.example
        compare = Controls::Schema.example

        compare.some_attribute = Controls::Attribute::Value.random

        control_name = :some_attribute

        list = [control_name]

        fixture = Equality.build(control, compare, list)
        fixture.()

        context "#{control_name}" do
          failed = fixture.test_session.test_failed?(control_name)

          test "Failed" do
            assert(failed)
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
