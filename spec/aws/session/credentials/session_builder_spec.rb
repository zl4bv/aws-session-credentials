describe Aws::Session::Credentials::SessionBuilder do
  let(:config) { {} }
  let(:client) { double('client') }

  subject { Aws::Session::Credentials::SessionBuilder.new(config, client) }

  describe '#session_credentials' do
    let(:response) { double('response', credentials: 'a') }

    before do
      allow(client).to receive(:get_session_token).and_return(response)
    end

    its(:session_credentials) { is_expected.to eq('a') }
  end

  describe '#update_credential_file' do
    let(:config) { { 'profile' => 'p' } }
    let(:cred_file) { double('CredentialFile') }
    let(:creds) { 'a' }

    it 'updates the file with new session credentials' do
      expect(subject).to receive(:session_credentials).and_return(creds)
      expect(cred_file).to receive(:set_credentials).with('p', 'a')
      subject.update_credential_file(cred_file)
    end
  end
end
