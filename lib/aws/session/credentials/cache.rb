module Aws
  module Session
    module Credentials
      # Holds session credentials
      class Cache
        include ProfileStorage
        include FileProvider::YamlFileProvider

        attr_reader :path

        def initialize(options = {})
          @path = File.expand_path(options[:path] || default_path)
        end

        def default_path
          File.join(%w(~ .aws aws-session-cache.yml))
        end

        # @return [Hash<String,Hash>]
        def profiles_hash
          self['profiles'] || {}
        end

        # @param [Hash] hsh
        def profiles_hash=(hsh)
          self['profiles'] = hsh
        end
      end
    end
  end
end
