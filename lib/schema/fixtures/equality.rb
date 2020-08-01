module Schema
  module Fixtures
    class Equality
      include TestBench::Fixture
      include Initializer

      def ignore_class?
        @ignore_class ||= false
      end

      def print_title_context?
        if @print_title_context.nil?
          @print_title_context = true
        end
        @print_title_context
      end

      def title_context_name
        @title_context_name ||= "Schema Equality: #{comparison.control_class.type}, #{comparison.compare_class.type}"
      end

      def attributes_context_name
        @attributes_context_name ||= 'Attributes'
      end

      initializer :comparison, na(:ignore_class), na(:print_title_context), na(:title_context_name), na(:attributes_context_name)

      def self.build(control, compare, attribute_names=nil, ignore_class: nil, print_title_context: nil, title_context_name: nil, attributes_context_name: nil)
        comparison = Schema::Compare.(control, compare, attribute_names)
        new(comparison, ignore_class, print_title_context, title_context_name, attributes_context_name)
      end

      def call()
        control_class = comparison.control_class
        compare_class = comparison.compare_class

        test_attributes = proc do
          context attributes_context_name do
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

        if print_title_context?
          context "#{title_context_name}" do
            detail "Control Class: #{control_class.name}"
            detail "Compare Class: #{compare_class.name}"

            if not ignore_class?
              test "Classes are the same" do
                assert(control_class == compare_class)
              end
            else
              detail 'Class comparison is ignored'
            end

            test_attributes.()
          end
        else
          test_attributes.()
        end
      end
    end
  end
end
