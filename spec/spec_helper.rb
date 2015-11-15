$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'aws/session/credentials'

require 'shared_examples/file_provider/ini_file_provider'
require 'shared_examples/file_provider/yaml_file_provider'
require 'shared_examples/file_provider'
require 'shared_examples/mfa_device'
require 'shared_examples/profile_store'

require 'rspec/its'
