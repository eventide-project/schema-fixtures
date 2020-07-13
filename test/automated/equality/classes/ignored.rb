require_relative '../../automated_init'

context "Equality" do
  context "Classes" do
    context "Ignored" do
      control = Controls::Schema.example
      compare = Controls::Schema.other_example

      fixture = Equality.build(control, compare, ignore_class: true)
      fixture.()

      tested = fixture.test_session.test?('Classes are the same')

      test "Not tested" do
        refute(tested)
      end
    end
  end
end
