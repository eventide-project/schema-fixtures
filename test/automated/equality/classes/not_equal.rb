require_relative '../../automated_init'

context "Equality" do
  context "Classes" do
    context "Not Equal" do
      control = Controls::Schema.example
      compare = Controls::Schema.other_example

      fixture = Equality.build(control, compare)
      fixture.()

      failed = fixture.test_session.test_failed?('Classes are the same')

      test "Failed" do
        assert(failed)
      end
    end
  end
end
