describe Aws::Session::Credentials::CredentialFile do
  let(:path) { '/path/to/ini/file' }

  subject { Aws::Session::Credentials::CredentialFile.new(path, ini_file)}

  before do
    allow(File).to receive(:expand_path).and_return(path)
  end

  describe '#set_credentials' do
    let(:ini_file) { double('inifile') }
    let(:profile) { 'a' }

    before do
      allow(ini_file).to receive(:write)
    end

    context 'when profile is provided' do
      it 'reads and writes section with provided profile name' do
        expect(ini_file).to receive(:[]).with(profile).and_return({})
        expect(ini_file).to receive(:[]=).with(profile, {})
        subject.set_credentials(profile)
      end
    end

    context 'when no options provided' do
      it 'does not modify section' do
        expect(ini_file).to receive(:[]).with(profile).and_return({})
        expect(ini_file).to receive(:[]=).with(profile, {})
        subject.set_credentials(profile)
      end
    end

    context 'when options provided' do
      context 'when some options provided' do
        let(:first) { { 'aws_access_key_id' => 'a' } }
        let(:second) { { 'foo' => 'bar' } }
        let(:both) { { 'aws_access_key_id' => 'a', 'foo' => 'bar' } }

        it 'does not modify existing options that are not provided' do
          expect(ini_file).to receive(:[]).with(profile).and_return(first)
          expect(ini_file).to receive(:[]=).with(profile, both)
          subject.set_credentials(profile, second)
        end
      end

      context 'when option already exists' do
        let(:first) { { 'a' => 'b' } }
        let(:second) { { 'a' => 'c' } }

        it 'replaces option with new value' do
          expect(ini_file).to receive(:[]).with(profile).and_return(first)
          expect(ini_file).to receive(:[]=).with(profile, second)
          subject.set_credentials(profile, second)
        end
      end

      context 'when option does not already exist' do
        let(:options) { { 'a' => 'b' } }

        it 'adds the option' do
          expect(ini_file).to receive(:[]).with(profile).and_return({})
          expect(ini_file).to receive(:[]=).with(profile, options)
          subject.set_credentials(profile, options)
        end
      end
    end
  end
end
