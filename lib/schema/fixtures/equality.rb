module Schema
  module Fixtures
    class Equality
      include TestBench::Fixture
      include Initializer

      def ignore_class?
        @ignore_class ||= false
      end

      initializer :comparison, na(:ignore_class)

      def self.build(control, compare, attribute_names=nil, ignore_class: nil)
        comparison = Schema::Compare.(control, compare, attribute_names)
        new(comparison, ignore_class)
      end

      def call()
        control_class = comparison.control_class
        compare_class = comparison.compare_class

        context "Schema Equality: #{control_class.type}, #{compare_class.type}" do
          detail "Control Class: #{control_class.name}"
          detail "Compare Class: #{compare_class.name}"

          if not ignore_class?
            test "Classes are the same" do
              assert(control_class == compare_class)
            end
          else
            detail 'Class comparison is ignored'
          end

          context "Attributes" do
            comparison.entries.each do |entry|
              printed_attribute_name = Attribute.printed_name(entry)

              control_attribute_value = entry.control_value
              compare_attribute_value = entry.compare_value

              test printed_attribute_name do
                detail "Control Value: #{control_attribute_value.inspect}"
                detail "Compare Value: #{compare_attribute_value.inspect}"

                assert(compare_attribute_value == control_attribute_value)
              end
            end
          end
        end
      end
    end
  end
end
