RSpec.describe XssRspec::DummyDataCreator::Generator do
  describe ".generate_attribute" do
    subject { XssRspec::DummyDataCreator::Generator.generate_attribute("mock_users") }

    it "include all key" do
      MockUser.columns_hash.keys.each { |column|
        expect(subject).to have_key(column)
      }
    end
  end

  describe ".dummy_value" do
    subject { XssRspec::DummyDataCreator::Generator.send(:dummy_value, "mock_users", column) }
    before do
      allow(XssRspec::DummyDataCreator::DbParser).to receive(:xss_injectable_columns) {
        [:string]
      }
    end
    
    context "when colum is id" do
      let(:column) { :id }
      it "return 1" do
        expect(subject).to eq 1
      end
    end

    context "when colum is created_at" do
      let(:column) { :created_at }
      it "return current time" do
        expect(subject).to eq Time.now
      end
    end

    context "when column is name" do
      let(:column) { :name }
      it "return xss" do
        expect(subject).to eq "<script>alert('xss:mock_users:name')</script>"
      end
    end
  end
end
