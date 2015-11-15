require 'spec_helper'

describe Aws::Session::Credentials::CredentialFile do
  it_behaves_like 'an ini file provider'
  it_behaves_like 'a profile store'
end
