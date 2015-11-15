describe Aws::Session::Credentials::Profile do
  describe '#aws_credentials' do
    its(:aws_credentials) { is_expected.to be_a(Aws::Credentials) }
  end

  describe '#to_h' do
    context 'when initalized with arguments' do
      subject { described_class.new(foo: 'bar') }

      its(:to_h) { is_expected.to eq(foo: 'bar') }
    end

    context 'when initialized without arguments' do
      its(:to_h) { is_expected.to eq({}) }
    end
  end
end
