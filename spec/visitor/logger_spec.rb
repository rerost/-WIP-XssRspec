RSpec.describe XssRspec::Checker::Logger do
  subject { XssRspec::Checker::Logger.log(path, alert_txt) }
  let(:path) { "/test" }
  let(:alert_txt) { "mock_users-email" }

  before do
    allow(XssRspec::Checker::Logger).to receive(:sprintf) { |*args|
      args.slice(1, args.length - 1).join("-")
    }
  end

  it "return page and alert data" do
    expect(subject).to eq "/test-mock_users-email"
  end
end
