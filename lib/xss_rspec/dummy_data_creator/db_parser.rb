require 'active_record'

module XssRspec
  module DummyDataCreator
    module DbParser
      class << self
        def tables
          ActiveRecord::Base.connection.tables - ["schema_migrations", "ar_internal_metadata"]
        end

        def xss_injectable_columns(table)
          klass = table.classify.constantize
          klass.columns_hash
            .select { |k, v| xss_injectable_types.include?(v.type) }
            .map { |k, v| k }
        end

        def column_types(table)
          klass = table.classify.constantize
          klass.columns_hash
            .map { |k, v| [k, v.type] }
            .to_h
        end
        
        ## TODO(@rerost) FIX ME
        ## This does the same thing as column_types and the computational complexity is not good
        def column_type(table, column)
          klass = table.classify.constantize
          klass.columns_hash
            .select { |k, _| k == column }
            .map { |_, v| v.type }
            .first
        end

        def xss_injectable_types
          return [:string] 
        end
      end
    end
  end
end
