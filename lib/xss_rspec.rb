require_relative "xss_rspec/version"
require_relative "xss_rspec/dummy_data_creator"
require_relative "xss_rspec/checker"

module XssRspec
  class << self
    def initialize
      # NOTE: To Easiery check URL
      ApplicationRecord.module_eval do
        def self.find(ids)
          self.first
        end
      
        def self.where(*args)
          self.all
        end
      end
    end

    def create_all
      DummyDataCreator.create_all_attribute.each{ |table, attribute|
        table.new(attribute).save(validate: false)
      }
    end

    def visit_all
      Checker::Visitor.visit_all
    end
  end
end
