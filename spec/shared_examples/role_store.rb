shared_examples 'a role store' do
  let(:rls_hash) { {} }

  subject(:store) { described_class.new }

  before do
    allow(store).to receive(:rls_hash).and_return(rls_hash)
  end

  it { expect(store).to respond_to(:roles_hash) }
  it { expect(store).to respond_to(:roles_hash=) }
  it { expect(store).to respond_to(:roles) }
  it { expect(store).to respond_to(:roles=) }
  it { expect(store).to respond_to(:role) }
  it { expect(store).to respond_to(:set_role) }

  describe '#roles' do
    context 'when there are no roles' do
      its(:roles) { is_expected.to eq({}) }
    end

    context 'when there is a role' do
      let(:rls_hash) { { 'default' => {} } }

      it { expect(store.roles).to have_key('default') }
      it { expect(store.roles['default']).to be_a(Aws::Session::Credentials::Role) }
    end
  end

  describe '#roles=' do
    let(:rls) { { 'default' => Aws::Session::Credentials::Role.new } }
    let(:rls_hash) { { 'default' => {} } }

    it 'stores the roles as hashes' do
      expect(store).to receive(:roles_hash=).with(rls_hash)
      store.roles = rls
    end
  end

  describe '#role' do
    let(:rls_hash) { { 'default' => { 'a' => 'bar' } } }

    it 'returns a Role' do
      expect(store.role('default')).to be_a(Aws::Session::Credentials::Role)
    end

    it 'returns role for provided alias' do
      expect(store.role('default').a).to eq('bar')
    end
  end
end
