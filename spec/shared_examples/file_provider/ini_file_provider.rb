shared_examples 'an ini file provider' do
  let(:provider) { described_class.new }

  it_behaves_like 'a file provider'

  describe '#read' do
    context 'when ini file exists' do
      before do
        allow(File).to receive(:exist?).and_return(true)
      end

      it 'reads from existing ini file' do
        expect(IniFile).to receive(:load)
        provider.read
      end
    end

    context 'when ini file does not exist' do
      before do
        allow(File).to receive(:exist?).and_return(false)
      end

      it 'creates a new ini file' do
        expect(IniFile).to receive(:new)
        provider.read
      end
    end
  end
end
