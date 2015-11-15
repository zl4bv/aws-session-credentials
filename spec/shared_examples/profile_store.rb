shared_examples 'a profile store' do
  let(:prfs_hash) { {} }

  subject(:store) { described_class.new }

  before do
    allow(store).to receive(:profiles_hash).and_return(prfs_hash)
  end

  it { expect(store).to respond_to(:profiles_hash) }
  it { expect(store).to respond_to(:profiles_hash=) }
  it { expect(store).to respond_to(:profiles) }
  it { expect(store).to respond_to(:profiles=) }
  it { expect(store).to respond_to(:profile) }
  it { expect(store).to respond_to(:set_profile) }

  describe '#profiles' do
    context 'when there are no profiles' do
      its(:profiles) { is_expected.to eq({}) }
    end

    context 'when there is a profile' do
      let(:prfs_hash) { { 'default' => {} } }

      it { expect(store.profiles).to have_key('default') }
      it { expect(store.profiles['default']).to be_a(Aws::Session::Credentials::Profile) }
    end
  end

  describe '#profiles=' do
    let(:prfs) { { 'default' => Aws::Session::Credentials::Profile.new } }
    let(:prfs_hash) { { 'default' => {} } }

    it 'stores the profiles as hashes' do
      expect(store).to receive(:profiles_hash=).with(prfs_hash)
      store.profiles = prfs
    end
  end

  describe '#profile' do
    let(:prfs_hash) { { 'default' => { 'a' => 'bar' } } }

    it 'returns a Profile' do
      expect(store.profile('default')).to be_a(Aws::Session::Credentials::Profile)
    end

    it 'returns profile for provided name' do
      expect(store.profile('default').a).to eq('bar')
    end
  end
end
