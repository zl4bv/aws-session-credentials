module Aws
  module Session
    module Credentials
      class Profile < OpenStruct
        def aws_credentials
          Aws::Credentials.new(aws_access_key_id,
                               aws_secret_access_key,
                               aws_session_token)
        end
      end
    end
  end
end
