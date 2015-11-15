module Aws
  module Session
    module Credentials
      # Builds AWS session
      class SessionBuilder
        # @param [Hash] options
        def initialize(options)
          @mfa_device = options.fetch(:mfa_device)
          @session_duration_seconds = options.fetch(:session_duration_seconds) { 86_400 }
          @source_profile = options.fetch(:source_profile)
          @sts_client = options.fetch(:sts_client) { nil }
        end

        # @return [Profile]
        def session_profile
          resp = sts_client.get_session_token(
            duration_seconds: @session_duration_seconds,
            serial_number: @mfa_device.device_arn,
            token_code: @mfa_device.code
          )
          return Profile.new(
            aws_access_key_id: resp.credentials['access_key_id'],
            aws_secret_access_key: resp.credentials['secret_access_key'],
            aws_session_token: resp.credentials['session_token']
          ) if resp
        end

        # @api private
        def sts_client
          @client ||= Aws::STS::Client.new(
            region: @source_profile.aws_region,
            credentials: @source_profile.aws_credentials
          )
        end
      end
    end
  end
end
