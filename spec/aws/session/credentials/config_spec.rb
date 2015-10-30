require 'spec_helper'

describe Aws::Session::Credentials::Config do
  subject { described_class.new(nil, config) }

  describe '#[]' do
    let(:config) { { 'k' => 'v' } }

    subject { described_class.new(nil, config) }

    its(['k']) { is_expected.to eq('v') }
  end

  describe '#[]=' do
    let(:config) { {} }

    before do
      subject['k'] = 'v'
    end

    its(['k']) { is_expected.to eq('v') }
  end

  describe '#aws_access_key_id' do
    let(:config) { { 'aws_access_key_id' => 'v' } }

    its(:aws_access_key_id) { is_expected.to eq('v') }
  end

  describe '#aws_secret_access_key' do
    let(:config) { { 'aws_secret_access_key' => 'v' } }

    its(:aws_secret_access_key) { is_expected.to eq('v') }
  end

  describe '#credential_file' do
    let(:config) { { 'credential_file' => 'v' } }

    its(:credential_file) { is_expected.to eq('v') }
  end

  describe '#duration' do
    let(:config) { { 'duration' => 'v' } }

    its(:duration) { is_expected.to eq('v') }
  end

  describe '#load_file' do
    let(:config) { {} }
    context 'when file exists' do
      let(:hash) { { 'k' => 'v' } }

      before do
        allow(File).to receive(:exist?).and_return(true)
        allow(File).to receive(:read).with(nil)
        allow(YAML).to receive(:load).and_return(hash)
      end

      its(:load_file) { is_expected.to eq(hash) }
    end

    context 'when file does not exist' do
      before do
        allow(File).to receive(:exist?).and_return(false)
      end

      it 'does not attempt to read from non-existent file' do
        expect(File).to_not receive(:read)
      end

      its(:load_file) { is_expected.to eq({}) }
    end
  end

  describe '#mfa_code' do
    let(:config) { { 'mfa_code' => 'v' } }

    its(:mfa_code) { is_expected.to eq('v') }
  end

  describe '#mfa_device' do
    let(:config) { { 'mfa_device' => 'v' } }

    its(:mfa_device) { is_expected.to eq('v') }
  end

  describe '#profile' do
    let(:config) { { 'profile' => 'v' } }

    its(:profile) { is_expected.to eq('v') }
  end

  describe '#region' do
    let(:config) { { 'region' => 'v' } }

    its(:region) { is_expected.to eq('v') }
  end

  describe '#to_h' do
    let(:config) { { 'k' => 'v' } }

    its(:to_h) { is_expected.to eq(config) }
  end
end
