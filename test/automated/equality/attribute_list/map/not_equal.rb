require_relative '../../../automated_init'

context "Equality" do
  context "Attribute List" do
    context "Map" do
      context "Equal" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema::Equivalent.example

        compare.yet_another_attribute = Controls::Attribute::Value.random

        control_name = :some_other_attribute
        compare_name = :yet_another_attribute

        map = [
          { control_name => compare_name }
        ]

        fixture = Equality.build(control, compare, map)
        fixture.()

        context "some_other_attribute => yet_another_attribute" do
          failed = fixture.test_session.test_failed?('some_other_attribute => yet_another_attribute')

          test "Failed" do
            assert(failed)
          end
        end

        context "some_attribute" do
          tested = fixture.test_session.test?('some_attribute')

          test "Not tested" do
            refute(tested)
          end
        end
      end
    end
  end
end
