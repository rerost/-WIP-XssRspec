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

        def dummy_value(table, column)
          column_type = DbParser.column_type(table, column) 
          if DbParser.xss_injectable_types.include? column_type
            ## Check which path is being used with referer
            return "<script src='#{log_host}/#{table}/#{column}')/>"
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

        def log_host
          return "http://localhost:3001"
        end
      end
    end
  end
end
