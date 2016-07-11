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
          cli_opts = options.transform_keys { |key| key.sub(/-/, '_').to_sym }
          SessionManager.new.new_session(cli_opts)
        end

        method_option 'role-alias',
                      type: :string,
                      desc: 'Name of stored role settings to use',
                      default: nil
        method_option 'role-account',
                      type: :string,
                      desc: 'Account ID',
                      default: nil
        method_option 'role-name',
                      type: :string,
                      desc: 'Name of role to assume',
                      default: nil
        method_option 'role-arn',
                      type: :string,
                      desc: 'The ARN of the role to assume; alternative to providing role-account and role-name',
                      default: nil
        method_option 'role-session-name',
                      type: :string,
                      desc: 'An identifier for the assumed role session',
                      default: nil
        method_option 'profile',
                      type: :string,
                      desc: 'Profile that session token will be loaded into',
                      default: nil
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
          cli_opts = options.transform_keys { |key| key.sub(/-/, '_').to_sym }

          if cli_opts['role_alias']
            cf = Config.new(path: cli_opts['config_file'])
            rl = cf.role(cli_opts['role_alias'].to_sym)
            cli_opts = rl.to_h.deep_stringify_keys.deep_merge(cli_opts)
          end

          cli_opts['role_arn'] ||= make_role_arn(cli_opts['role_account'], cli_opts['role_name'])

          SessionManager.new.assume_role(cli_opts.deep_symbolize_keys)
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
          cli_opts = options.transform_keys { |key| key.sub(/-/, '_').to_sym }
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

        method_option 'role-account',
                      type: :string,
                      desc: 'Account ID',
                      default: nil
        method_option 'role-name',
                      type: :string,
                      desc: 'Name of role to assume',
                      default: nil
        method_option 'role-arn',
                      type: :string,
                      desc: 'The ARN of the role to assume; alternative to providing role-account and role-name',
                      default: nil
        method_option 'role-session-name',
                      type: :string,
                      desc: 'An identifier for the assumed role session',
                      default: nil
        method_option 'config-file',
                      type: :string,
                      desc: 'YAML file to load config from',
                      default: '~/.aws/aws-session-config.yml'
        method_option 'role-alias',
                      type: :string,
                      desc: 'Name/alias associated with role',
                      default: nil
        method_option 'profile',
                      type: :string,
                      desc: 'Profile that will used when assuming role',
                      default: nil
        method_option 'duration',
                      type: :numeric,
                      desc: 'Duration, in seconds, that credentials for assumed role should remain valid',
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
        desc 'configure-role', 'Configures a new role'
        def configure_role
          cli_opts = options.transform_keys { |key| key.sub(/-/, '_') .to_sym }
          cli_opts['role_alias'] ||= ask('Provide an alias for this role:')

          if cli_opts['role_account'] && cli_opts['role_name']
            cli_opts['role_arn'] = make_role_arn(cli_opts['role_account'], cli_opts['role_name'])
          elsif !cli_opts['role_arn']
            puts ''
            if yes?('Provide role account and name instead of role ARN (y/n)?')
              account = ask('Role account ID:')
              role_name = ask('Name of role:')
              cli_opts['role_arn'] = make_role_arn(account, role_name)
            else
              cli_opts['role_arn'] = ask('Role ARN:')
            end
          end

          unless cli_opts['role_session_name']
            if yes?('Customise role session name (y/n)?')
              cli_opts['role_session_name'] = ask('Role session name:')
            else
              account, role_name = split_role_arn(cli_opts['role_arn'])
              cli_opts['role_session_name'] = "#{role_name}@#{account}"
            end
          end

          cli_opts['profile'] ||= ask('Profile to use when assuming role (leave blank to use "default"):')
          cli_opts['profile'] = 'default' if cli_opts['profile'].empty?

          cli_opts['duration'] ||= ask('Duration in seconds of assumed role:')

          rl = Role.new(cli_opts.except('config_file'))
          cf = Config.new(path: cli_opts['config_file'])
          cf.set_role(cli_opts[:role_alias], rl)
        end

        desc 'list-profiles', 'Lists profiles/sessions'
        def list_profiles
          store = CredentialFile.new

          puts "Profiles located in #{store.path}:"
          store.print_profiles(self)
        end

        method_option 'config-file',
                      type: :string,
                      desc: 'YAML file to load config from',
                      default: '~/.aws/aws-session-config.yml'
        desc 'list-roles', 'Lists roles that have been saved'
        def list_roles
          store = Config.new(path: options['config-file'])

          puts "Profiles located in #{store.path}:"
          store.print_roles(self)
        end

        method_option 'config-file',
                      type: :string,
                      desc: 'YAML file to load config from',
                      default: '~/.aws/aws-session-config.yml'
        desc 'list-source-profiles', 'Lists source profiles that have been saved'
        def list_source_profiles
          store = Config.new(path: options['config-file'])

          puts "Profiles located in #{store.path}:"
          store.print_profiles(self)
        end

        desc 'version', 'Prints the current version'
        def version
          puts "aws-session-credentials #{Aws::Session::Credentials::VERSION}"
        end

        no_tasks do
          def make_role_arn(account, role_name)
            "arn:aws:iam::#{account}:role/#{role_name}"
          end

          def split_role_arn(role_arn)
            role_arn.scan(%r{arn:aws:iam::(.+):role/(.+)}).first
          end
        end

        default_task :new
      end
    end
  end
end
