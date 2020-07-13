require_relative '../automated_init'

context "Assignment" do
  context "Not Assigned" do
    schema = Controls::Schema::DefaultValue.example

    fixture = Assignment.build(schema)
    fixture.()

    schema.class.attribute_names.each do |attribute_name|
      context attribute_name do
        failed = fixture.test_session.test_failed?(attribute_name)

        test "Failed" do
          assert(failed)
        end
      end
    end
  end
end
