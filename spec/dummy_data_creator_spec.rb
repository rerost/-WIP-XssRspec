RSpec.describe XssRspec::DummyDataCreator do
  subject { XssRspec::DummyDataCreator.create_all_attribute }

  it "include mock_users" do
    expect(subject).to have_key("mock_users")
  end
end
