shared_examples 'factory' do
  subject { create model_name }

  describe 'creatable' do
    let(:model_name) { described_class.to_s.underscore.to_sym }

    it { is_expected.to be_present }
  end
end

shared_examples 'factory as' do |model_name|
  describe "#{model_name} creatable" do
    subject { create model_name }
    it { is_expected.to be_present }
  end
end


shared_examples 'factory trait' do |*args|
  describe "#{args} creatable" do
    subject { create model_name, *args }
    let(:model_name) { described_class.to_s.underscore.to_sym }
    it { is_expected.to be_present }
  end
end
