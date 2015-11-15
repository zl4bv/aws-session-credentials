shared_examples 'a file provider' do
  let(:provider) { described_class.new }

  it { expect(provider).to respond_to(:[]) }
  it { expect(provider).to respond_to(:[]=) }
  it { expect(provider).to respond_to(:path) }
end
