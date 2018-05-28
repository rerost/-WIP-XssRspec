require_relative "xss_rspec/version"
require_relative "xss_rspec/dummy_data_creator"
require_relative "xss_rspec/checker"

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
