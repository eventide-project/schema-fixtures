require_relative '../automated_init'

context "Assignment" do
  context "Assigned" do
    schema = Controls::Schema::DefaultValue.example

    schema.some_attribute = Controls::Attribute::Value.random
    schema.some_other_attribute = Controls::Attribute::Value.random

    fixture = Assignment.build(schema)
    fixture.()

    schema.class.attribute_names.each do |attribute_name|
      attribute_name = attribute_name.to_s

      context attribute_name do
        passed = fixture.test_session.test_passed?(attribute_name)

        test "Passed" do
          assert(passed)
        end
      end
    end
  end
end
