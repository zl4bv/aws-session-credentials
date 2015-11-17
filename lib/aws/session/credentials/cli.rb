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
        method_option 'source-profile',
                      type: :string,
                      desc: 'Profile in config file that user credentials will be loaded from',
                      default: nil
        method_option 'duration',
                      type: :numeric,
                      desc: 'Duration, in seconds, that credentials should remain valid',
                      default: nil
        method_option 'mfa-device',
                      type: :string,
                      desc: 'ARN of MFA device',
                      default: nil
        method_option 'yubikey-name',
                      type: :string,
                      desc: 'Name of yubikey device',
                      default: 'Yubikey'
        method_option 'oath-credential',
                      type: :string,
                      desc: 'Name of OATH credential',
                      default: nil
        desc 'configure', 'Configures a new source profile'
        def configure
          cli_opts = options.transform_keys { |key| key.sub(/-/, '_') }
          cli_opts['source_profile'] ||= ask('Source profile (leave blank for "default"):')
          cli_opts['aws_access_key_id'] ||= ask('AWS Access Key ID:')
          cli_opts['aws_secret_access_key'] ||= ask('AWS Secret Access Key:', echo: false)
          puts '' # BUG: No LF printed when echo is set to false
          cli_opts['aws_region'] ||= ask('AWS region:')
          cli_opts['duration'] ||= ask('Session duration (in seconds):').to_i

          puts ''
          if yes?('Configure MFA (y/n)?')
            cli_opts['mfa_device'] ||= ask('MFA device ARN:')
            puts ''
            if yes?('Configure Yubikey (y/n)?')
              cli_opts['oath_credential'] ||= ask('OATH credential name:')
            end
          end

          cli_opts['source_profile'] = 'default' if cli_opts['source_profile'].empty?

          prof = Profile.new(cli_opts.except('config_file', 'source_profile'))
          cf = Config.new(path: cli_opts['config_file'])
          cf.set_profile(cli_opts[:source_profile], prof)
        end

        desc 'list-profiles', 'Lists profiles/sessions'
        def list_profiles
          store = CredentialFile.new

          puts "Available profiles in #{store.path}:"
          store.profiles.each { |name, _|  puts "  * #{name}" }
        end

        method_option 'config-file',
                      type: :string,
                      desc: 'YAML file to load config from',
                      default: '~/.aws/aws-session-config.yml'
        desc 'list-source-profiles', 'Lists source profiles that have been saved'
        def list_source_profiles
          store = Config.new(path: options['config-file'])

          puts "Available source profiles in #{store.path}:"
          store.profiles.each { |name, _|  puts "  * #{name}" }
        end

        desc 'version', 'Prints the current version'
        def version
          puts "aws-session-credentials #{Aws::Session::Credentials::VERSION}"
        end

        default_task :new
      end
    end
  end
end
