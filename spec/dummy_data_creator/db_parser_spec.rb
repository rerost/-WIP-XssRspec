RSpec.describe XssRspec::DummyDataCreator::DbParser do
  before do
    class ActiveRecord::Base
    end

    class Faker
      def initialize(value, type)
        @value = value
        @type = type
      end

      def type
        @type
      end
    end

    class Test
      def self.columns_hash
        return {
          user_name: Faker.new("asd", :string),
          user_id: Faker.new(1, :int),
        }
      end
    end

    allow(ActiveRecord::Base).to receive(:connection) {
      a = Class.new
      a.tables = ["test", "schema_migrations", "ar_internal_metadata"]
      a
    }
  end

  context "#xss_injectable_columns" do
    subject { XssRspec::DummyDataCreator::DbParser.xss_injectable_columns("test") }
    
    it "return string column name" do
      expect(subject).to eq [:user_name]
    end
  end

  context "#column_types" do
    subject { XssRspec::DummyDataCreator::DbParser.column_types("test") }
    
    it "return column key and type" do
      expect_hash = {
        user_id: :int,
        user_name: :string,
      }
      expect(subject).to eq expect_hash
    end
  end
end