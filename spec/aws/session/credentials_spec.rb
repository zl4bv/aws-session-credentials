require 'spec_helper'

describe Aws::Session::Credentials do
  it 'has a version number' do
    expect(Aws::Session::Credentials::VERSION).not_to be nil
  end
end
