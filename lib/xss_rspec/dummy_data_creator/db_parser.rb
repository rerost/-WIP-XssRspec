require 'active_record'

module XssRspec
  module DummyDataCreator
    module DbParser
      class << self
        def tables
          ActiveRecord::Base.descendants.select { |table| !table.table_name.nil? }
        end

        def xss_injectable_columns(table)
          table.columns_hash
            .select { |_, v| xss_injectable_types.include?(v.type) }
            .map { |k, _| k }
        end

        def column_types(table)
          table.columns_hash
            .map { |k, v| [k, v.type] }
            .to_h
        end
        
        ## TODO(@rerost) FIX ME
        ## This does the same thing as column_types and the computational complexity is not good
        def column_type(table, column)
          table.columns_hash
            .select { |k, _| k == column }
            .map { |_, v| v.type }
            .first
        end

        def xss_injectable_types
          return [:string, :text] 
        end
      end
    end
  end
end
