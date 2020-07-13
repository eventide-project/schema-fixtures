require_relative '../../../automated_init'

context "Equality" do
  context "Attribute List" do
    context "Map" do
      context "Equal" do
        control = Schema::Controls::Schema.example
        compare = Schema::Controls::Schema::Equivalent.example

        control_name = :some_other_attribute
        compare_name = :yet_another_attribute

        map = [
          { control_name => compare_name }
        ]

        fixture = Equality.build(control, compare, map, ignore_class: true)
        fixture.()

        context "Classes are the same" do
          tested = fixture.test_session.test?('Classes are the same')

          test "Not tested" do
            refute(tested)
          end
        end

        context "some_other_attribute => yet_another_attribute" do
          passed = fixture.test_session.test_passed?('some_other_attribute => yet_another_attribute')

          test "Passed" do
            assert(passed)
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
