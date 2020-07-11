module Schema
  module Fixtures
    class Equality
      include TestBench::Fixture
      include Initializer

      initializer :comparison

      def self.build(control, compare, attribute_names=nil)
        comparison = Schema::Compare.(control, compare, attribute_names)

        new(comparison)
      end

      def call()
        control_class = comparison.control_class
        compare_class = comparison.compare_class

        context "Schema Equality: #{control_class.type}, #{compare_class.type}" do

          detail "Control Class: #{control_class.name}"
          detail "Compare Class: #{compare_class.name}"

          comparison.entries.each do |entry|

            printed_attribute_name = self.class.printed_attribute_name(entry)

            test printed_attribute_name do

              assert do

                control_attribute_value = entry.control_value
                compare_attribute_value = entry.compare_value

                comment "Control Value: #{control_attribute_value.inspect}"
                comment "Compare Value: #{compare_attribute_value.inspect}"

                assert(compare_attribute_value == control_attribute_value)
              end
            end
          end
        end
      end

      def self.printed_attribute_name(entry)
        control_name = entry.control_name
        compare_name = entry.compare_name

        if control_name == compare_name
          return control_name.to_s
        else
          return "#{control_name} => #{compare_name}"
        end
      end
    end
  end
end
