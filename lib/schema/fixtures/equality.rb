module Schema
  module Fixtures
    class Equality
      include TestBench::Fixture
      include Initializer

      initializer :control, :compare

      def call()
        comparison = Schema::Compare.(control, compare)

        control_class = comparison.control_class
        compare_class = comparison.compare_class

        context "Schema Equality: #{control_class.type}, #{compare_class.type}" do

          verbose "Control Class: #{control_class.name}"
          verbose "Compare Class: #{compare_class.name}"

          comparison.entries.each do |entry|

            printed_attribute_name = self.class.printed_attribute_name(entry)

            context printed_attribute_name do

              assert do

                control_attribute_value = entry.control_value
                compare_attribute_value = entry.compare_value

# Uncomment to cause block form failure, and display of comments
# compare_attribute_value = nil

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
          return control_name
        else
          return "#{control_name} (=> #{compare_name})"
        end
      end
    end
  end
end
