shared_examples 'an mfa device' do
  let(:device) { described_class.new }

  it { expect(device).to respond_to(:code) }
  it { expect(device).to respond_to(:device_arn) }
end
