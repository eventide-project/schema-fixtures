module Schema
  module Fixtures
    class Assignment
      include TestBench::Fixture
      include Initializer

      def print_title_context?
        if @print_title_context.nil?
          @print_title_context = true
        end
        @print_title_context
      end

      def title_context_name
        @title_context_name ||= "Schema Assignment: #{comparison.compare_class.type}"
      end

      def attributes_context_name
        @attributes_context_name ||= 'Attributes'
      end

      initializer :comparison, na(:print_title_context), na(:title_context_name), na(:attributes_context_name)

      def self.build(compare, attribute_names=nil, print_title_context: nil, title_context_name: nil, attributes_context_name: nil)
        control = compare.class.new
        comparison = Schema::Compare.(control, compare, attribute_names)
        new(comparison, print_title_context, title_context_name, attributes_context_name)
      end

      def call()
        schema_class = comparison.control_class

        test_attributes = proc do
          context attributes_context_name do
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

        if print_title_context?
          context "#{title_context_name}" do
            detail "Class: #{schema_class.name}"

            test_attributes.()
          end
        else
          test_attributes.()
        end
      end
    end
  end
end
