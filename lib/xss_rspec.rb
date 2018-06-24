require_relative "xss_rspec/version"
require_relative "xss_rspec/dummy_data_creator"
require_relative "xss_rspec/checker"
#require "active_record"

# NOTE: To Easiery construct URL
ApplicationRecord.module_eval do
  def self.find(ids)
    self.first
  end

  def self.where(*args)
    self.all
  end
end

module XssRspec
  class << self
    def create_all
      DummyDataCreator.create_all_attribute.each{ |table, attribute|
        klass = table.classify.constantize
        klass.new(attribute).save(validate: false)
      }
    end
  end
end