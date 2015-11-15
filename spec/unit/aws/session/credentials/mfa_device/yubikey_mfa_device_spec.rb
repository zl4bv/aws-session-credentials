require 'spec_helper'

describe Aws::Session::Credentials::MfaDevice::YubikeyMfaDevice do
  it_behaves_like 'an mfa device'
end
