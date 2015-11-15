module Aws
  module Session
    module Credentials
      module MfaDevice
        # Represents generic MFA device that generates codes. Class must be
        # initialized with the code.
        class GenericMfaDevice
          attr_reader :code
          attr_reader :device_arn

          def initialize(options = {})
            @code = options[:code]
            @device_arn = options[:device_arn]
          end
        end
      end
    end
  end
end
