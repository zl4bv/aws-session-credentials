module Aws
  module Session
    module Credentials
      module MfaDevice
        # Gets MFA codes from a Yubikey using YubiOATH
        class YubikeyMfaDevice
          attr_reader :device_arn

          def initialize(options = {})
            @yubikey_name = options.fetch(:yubikey_name) { 'Yubikey' }
            @oath_credential = options[:oath_credential]
            @device_arn = options[:device_arn]
          end

          def code
            card_names.each do |card_name|
              card(card_name) do |crd|
                oath = YubiOATH.new(crd)
                codes = oath.calculate_all(timestamp: Time.now)
                # Credential names are returned as ASCII-8BIT
                codes.transform_keys! { |key| key.force_encoding('UTF-8') }
                return codes[@oath_credential]
              end
            end
            nil
          end

          private

          # @param [String] name
          # @yieldparam card [Smartcard::PCSC::Card]
          def card(name)
            context do |cxt|
              begin
                crd = cxt.card(name, :shared)
                yield crd
              ensure
                crd.disconnect unless crd.nil?
              end
            end
          end

          # @return [Array<String>]
          def card_names
            context do |cxt|
              cxt.readers.select { |name| name.include?(@yubikey_name) }
            end
          end

          # @yieldparam context [Smartcard::PCSC::Context]
          def context
            context = Smartcard::PCSC::Context.new
            yield context
          ensure
            context.release
          end
        end
      end
    end
  end
end
