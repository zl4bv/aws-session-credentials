module Aws
  module Session
    module Credentials
      # Manages sessions
      class SessionManager
        # Assumes a role from provided options
        # @param [Hash] options
        # @option options [String] :profile
        # @option options [String] :role_arn
        # @option options [String] :duration
        def assume_role(options)
          options[:profile] = options[:profile].to_sym

          session_prof = Cache.new.profile(options[:profile])
          options = session_prof.to_h.deep_merge(options).deep_symbolize_keys

          sb = SessionBuilder.new(
            mfa_device: mfa_device(options),
            role_duration_seconds: options[:duration],
            role_arn: options[:role_arn],
            role_session_name: options[:role_session_name],
            source_profile: session_prof
          )
          role_profile = sb.role_profile

          CredentialFile.new.set_profile(options[:profile], role_profile)
        end

        # Creates a new session from provided options
        # @param [Hash] options
        # @option options [String] :aws_access_key_id
        # @option options [String] :aws_secret_access_key
        # @option options [String] :aws_session_token
        # @option options [String] :aws_region
        # @option options [String] :source_profile
        # @option options [String] :profile
        # @option options [String] :duration
        # @option options [String] :mfa_device
        # @option options [String] :mfa_code
        # @option options [String] :yubikey_name
        # @option options [String] :oath_credential
        # @option options [String] :config_file
        def new_session(options)
          options[:source_profile] = options[:source_profile].to_sym
          options[:profile] = options[:profile].to_sym

          user_prof = user_profile(options[:source_profile], options[:config_file])
          options = user_prof.to_h.deep_merge(options).deep_symbolize_keys

          sb = SessionBuilder.new(
            mfa_device: mfa_device(options),
            session_duration_seconds: options[:duration],
            source_profile: user_prof
          )
          set_user_session_profile(options[:profile], sb.session_profile)
        end

        private

        def mfa_device(options)
          opts = {
            device_arn: options[:mfa_device],
            yubikey_name: options[:yubikey_name],
            oath_credential: options[:oath_credential],
            code: options[:mfa_code]
          }
          if options.key?(:oath_credential)
            MfaDevice::YubikeyMfaDevice.new(opts)
          else
            MfaDevice::GenericMfaDevice.new(opts)
          end
        end

        def set_user_session_profile(name, profile)
          [Cache.new, CredentialFile.new].each do |profile_store|
            profile_store.set_profile(name, profile)
          end
        end

        def user_profile(name, path)
          Config.new(path: path).profile(name)
        end

        def user_session_profile(name)
          Cache.new.profile(name)
        end
      end
    end
  end
end
