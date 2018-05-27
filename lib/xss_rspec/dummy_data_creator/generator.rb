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
          column_type = DbParser.column_type(table, column) 
          if DbParser.xss_injectable_types.include? column_type
            return "<script>alert('xss:#{table}:#{column}')</script>"
          end

          case column_type
          when :integer
            1
          when :datetime
            Time.now
          else
            ## TODO(@rerost) Think proper error
            raise NameError, "Passed unknown column type of #{column} #{column_type}"
          end
        end
      end
    end
  end
end
