require 'spec_helper'

describe Aws::Session::Credentials::Cache do
  it_behaves_like 'a yaml file provider'
  it_behaves_like 'a profile store'
end
