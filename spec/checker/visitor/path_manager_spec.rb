RSpec.describe XssRspec::Checker::Visitor::PathManager do
  context "#replace_path" do
    subject { XssRspec::Checker::Visitor::PathManager.replace_path(path, method) }

    context "when include number" do
      let(:path) { "/users/1000" }
      let(:method) { :GET }
      it "return whose num becomes 1" do
        expect(subject).to eq "/users/1"
      end
    end

    context "when include number and tail" do
      let(:path) { "/users/1000/edit" }
      let(:method) { :GET }
      it "return whose num becomes 1" do
        expect(subject).to eq "/users/1/edit"
      end
    end
  end
end