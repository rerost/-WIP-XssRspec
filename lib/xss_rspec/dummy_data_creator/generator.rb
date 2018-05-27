module XssRspec
  module DummyDataCreator
    module Generator
      class << self
        def generate_attribute(table)
          klass = table.classify.constantize
          columns = klass.columns.map(&:name)

          columns.map { |column| 
            [column, dummy_value(table, column)]
          }.to_h
        end

        private

        def dummy_value(table, column)
          if DbParser.xss_injectable_columns(table).include? column
            return "<script>alert('xss:#{table}:#{column}')</script>"
          end

          case DbParser.column_type(table, column)
          when :integer
            1
          when :datetime
            Time.now
          end
        end
      end
    end
  end
end
