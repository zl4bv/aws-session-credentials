require 'thor'
require 'aws/session/credentials'

module Aws
  module Session
    module Credentials
      # Command line interface
      class Cli < Thor
        method_option 'aws-access-key-id',
                      type: :string,
                      desc: 'Access key used to generate session token',
                      default: nil
        method_option 'aws-secret-access-key',
                      type: :string,
                      desc: 'Secret key used to generate session token',
                      default: nil
        method_option 'aws-region',
                      type: :string,
                      desc: 'AWS region to connect to',
                      default: nil
        method_option 'config-file',
                      type: :string,
                      desc: 'YAML file to load config from',
                      default: '~/.aws/aws-session-config.yml'
        method_option 'credential-file',
                      type: :string,
                      desc: 'INI file to save session credentials to',
                      default: '~/.aws/credentials'
        method_option 'source-profile',
                      type: :string,
                      desc: 'Profile in config file that user credentials will be loaded from',
                      default: 'default'
        method_option 'profile',
                      type: :string,
                      desc: 'Profile that session token will be loaded into',
                      default: 'default'
        method_option 'duration',
                      type: :numeric,
                      desc: 'Duration, in seconds, that credentials should remain valid',
                      default: nil
        method_option 'mfa-device',
                      type: :string,
                      desc: 'ARN of MFA device',
                      default: nil
        method_option 'mfa-code',
                      type: :string,
                      desc: 'Six digit code from MFA device',
                      default: nil
        method_option 'yubikey-name',
                      type: :string,
                      desc: 'Name of yubikey device',
                      default: 'Yubikey'
        method_option 'oath-credential',
                      type: :string,
                      desc: 'Name of OATH credential',
                      default: nil
        desc 'new', 'Generates new AWS session credentials'
        def new
          cli_opts = options.transform_keys { |key| key.sub(/-/, '_') }
          SessionManager.new.new_session(cli_opts)
        end

        method_option 'role_arn',
                      type: :string,
                      desc: 'The ARN of the role to assume',
                      required: true
        method_option 'role_session_name',
                      type: :string,
                      desc: 'An identifier for the assumed role session',
                      required: true
        method_option 'profile',
                      type: :string,
                      desc: 'Profile that session token will be loaded into',
                      default: 'default'
        method_option 'duration',
                      type: :numeric,
                      desc: 'Duration, in seconds, that credentials should remain valid',
                      default: nil
        method_option 'mfa-device',
                      type: :string,
                      desc: 'ARN of MFA device',
                      default: nil
        method_option 'mfa-code',
                      type: :string,
                      desc: 'Six digit code from MFA device',
                      default: nil
        method_option 'yubikey-name',
                      type: :string,
                      desc: 'Name of yubikey device',
                      default: 'Yubikey'
        method_option 'oath-credential',
                      type: :string,
                      desc: 'Name of OATH credential',
                      default: nil
        desc 'assume-role', 'Assumes a role'
        def assume_role
          cli_opts = options.transform_keys { |key| key.sub(/-/, '_') }
          SessionManager.new.assume_role(cli_opts)
        end

        default_task :new
      end
    end
  end
end
