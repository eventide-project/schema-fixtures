module Schema
  module Fixtures
    class Assignment
      include TestBench::Fixture
      include Initializer

      initializer :comparison

      def self.build(compare, attribute_names=nil)
        control = compare.class.new
        comparison = Schema::Compare.(control, compare, attribute_names)
        new(comparison)
      end

      def call()
        schema_class = comparison.control_class

        context "Schema Assignment: #{schema_class.type}" do
          detail "Class: #{schema_class.name}"

          context "Attributes" do
            comparison.entries.each do |entry|
              default_attribute_value = entry.control_value
              attribute_value = entry.compare_value

              test "#{entry.compare_name}" do
                detail "Default Value: #{default_attribute_value.inspect}"
                detail "Assigned Value: #{attribute_value.inspect}"

                refute(attribute_value == default_attribute_value)
              end
            end
          end
        end
      end
    end
  end
end
