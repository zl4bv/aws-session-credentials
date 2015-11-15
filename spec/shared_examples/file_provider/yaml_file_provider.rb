shared_examples 'a yaml file provider' do
  let(:provider) { described_class.new }

  it_behaves_like 'a file provider'

  it { expect(provider).to respond_to(:read) }

  describe '#read' do
    context 'when yaml file exists' do
      before do
        expect(File).to receive(:exist?).and_return(true)
      end

      it 'reads from existing yaml file' do
        expect(File).to receive(:read)
        expect(YAML).to receive(:load).and_return({})
        provider.read
      end
    end

    context 'when yaml file does not exist' do
      before do
        expect(File).to receive(:exist?).and_return(false)
      end

      its(:read) { is_expected.to eq({}) }
    end
  end

  describe '#write' do
    let(:file_double) { double('File') }

    it 'writes to yaml file' do
      expect(File).to receive(:open).and_yield(file_double)
      expect(YAML).to receive(:dump)
      expect(file_double).to receive(:write)
      provider.write({})
    end
  end
end
