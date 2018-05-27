require "bundler/setup"
require "xss_rspec"
require "timecop"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    class MockColumn
      def initialize(type: nil, name: nil)
        @_type = type
        @_name = name
      end
      def type
        return @_type
      end
      def name
        return @_name
      end
    end
    class MockUser
      def self.columns_hash
        {
          id: MockColumn.new(type: :integer, name: :id),
          name: MockColumn.new(type: :string, name: :name),
          created_at: MockColumn.new(type: :datetime, name: :created_at),
        }
      end

      def self.columns
        self.columns_hash.map { |k, _| 
          MockColumn.new(name: k.to_sym)
        }
      end
    end
    class MockConnection
      def tables
        ["mock_users"]
      end
    end
    allow(ActiveRecord::Base).to receive(:connection) { MockConnection.new }
    Timecop.freeze
  end
end
