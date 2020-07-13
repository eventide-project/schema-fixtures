module Schema
  module Fixtures
    module Attribute
      def self.printed_name(entry)
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
