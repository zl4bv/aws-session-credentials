require 'thor'
require 'aws/session/credentials'

module Aws
  module Session
    module Credentials
      # Command line interface
      class Cli < Thor
        method_option 'access-key-id',
                      type: :string,
                      desc: 'Access key used to generate session token',
                      default: nil
        method_option 'secret-access-key',
                      type: :string,
                      desc: 'Secret key used to generate session token',
                      default: nil
        method_option 'region',
                      type: :string,
                      desc: 'AWS region to connect to',
                      default: nil
        method_option 'config-file',
                      type: :string,
                      desc: 'YAML file to load config from',
                      default: '~/.aws/credentials.yml'
        method_option 'credential-file',
                      type: :string,
                      desc: 'INI file to save session credentials to',
                      default: '~/.aws/credentials'
        method_option 'profile',
                      type: :string,
                      desc: 'Profile that session token will be loaded into',
                      default: 'default'
        method_option 'duration',
                      type: :numeric,
                      desc: 'Duration, in seconds, that credentials should remain valid',
                      default: 1
        method_option 'mfa-device',
                      type: :string,
                      desc: 'ARN of MFA device',
                      default: nil
        method_option 'mfa-code',
                      type: :numeric,
                      desc: 'Six digit code from MFA device',
                      default: nil
        desc 'Generates new AWS session credentials'
        def new_aws_session
          config = Config.new(options['config-file'])
          config.access_key_id      ||= options['access-key-id']
          config.secret_access_key  ||= options['secret-access-key']
          config.region             ||= options['region']
          config.credential_file    ||= options['credential-file']
          config.profile            ||= options['profile']
          config.duration           ||= options['duration']
          config.mfa_device         ||= options['mfa-device']

          cf = CredentialFile.new(config.credential_file)
          sb = SessionBuilder.new(config.to_h)
          sb.update_credential_file(cf)
        end

        default_task :new_aws_session
      end
    end
  end
end
