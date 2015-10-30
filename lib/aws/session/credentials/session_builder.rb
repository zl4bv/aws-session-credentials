module Aws
  module Session
    module Credentials
      # Builds AWS session
      class SessionBuilder
        # @param [Hash] config configuration
        # @param [Aws::STS::Client] client STS client
        def initialize(config, client = nil)
          @config = config
          @client = client || init_client
        end

        # @api private
        def init_client
          Aws::STS::Client.new(
            region: @config['region'],
            access_key_id: @config['aws_access_key_id'],
            secret_access_key: @config['aws_secret_access_key']
          )
        end

        # Gets a set of session credentials
        #
        # @return [Aws::STS::Types::Credentials] credentials or +nil+
        def session_credentials
          resp = @client.get_session_token(
            duration_seconds: @config['duration'],
            serial_number: @config['mfa_device'],
            token_code: @config['mfa_code']
          )
          return resp.credentials if resp
        end

        # Gets a set of session credentials and updates them in a credential
        # file.
        #
        # @param [String] path location of credential file
        def update_credential_file(credential_file)
          credential_file.set_credentials(@config['profile'], session_credentials)
        end
      end
    end
  end
end
