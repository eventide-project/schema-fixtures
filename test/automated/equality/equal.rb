require_relative '../automated_init'

context "Equality" do
  context "Equal" do
    control = Controls::Schema.example
    compare = Controls::Schema.example

    fixture = Equality.build(control, compare)
    fixture.()

    control.class.attribute_names.each do |attribute_name|
      context attribute_name do
        passed = fixture.test_session.test_passed?(attribute_name)

        test "Passed" do
          assert(passed)
        end
      end
    end
  end
end
