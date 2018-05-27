require_relative "dummy_data_creator/generator"
require_relative "dummy_data_creator/db_parser"

module XssRspec
  module DummyDataCreator
    class << self
      def create_all_attribute
        DbParser.tables.map { |table|
          [table, create_attribute(table)]
        }
      end
  
      def create_attribute(table)
        Generator.generate_attribute(table)
      end
    end
  end
end
