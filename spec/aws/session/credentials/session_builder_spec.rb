describe Aws::Session::Credentials::SessionBuilder do
  let(:config) { {} }
  let(:client) { double('client') }
  let(:creds) { { 'access_key_id' => nil, 'secret_access_key' => nil, 'session_token' => nil } }
  let(:converted_creds) { { 'aws_access_key_id' => nil, 'aws_secret_access_key' => nil, 'aws_session_token' => nil } }

  subject { Aws::Session::Credentials::SessionBuilder.new(config, client) }

  describe '#session_credentials' do
    let(:response) { double('response', credentials: creds) }

    before do
      allow(client).to receive(:get_session_token).and_return(response)
    end

    its(:session_credentials) { is_expected.to eq(converted_creds) }
  end

  describe '#update_credential_file' do
    let(:config) { { 'profile' => 'p' } }
    let(:cred_file) { double('CredentialFile') }

    it 'updates the file with new session credentials' do
      expect(subject).to receive(:session_credentials).and_return(converted_creds)
      expect(cred_file).to receive(:set_credentials).with('p', converted_creds)
      subject.update_credential_file(cred_file)
    end
  end
end
