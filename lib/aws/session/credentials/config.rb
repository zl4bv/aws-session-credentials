module Aws
  module Session
    module Credentials
      # Holds configuration
      class Config
        def initialize(path, config = nil)
          @path = File.expand_path(path) if path
          @config = config || load_file
        end

        def [](key)
          @config[key]
        end

        def []=(key, value)
          @config[key] = value
        end

        def aws_access_key_id
          self['aws_access_key_id']
        end

        def aws_access_key_id=(value)
          self['aws_access_key_id'] = value
        end

        def aws_secret_access_key
          self['aws_secret_access_key']
        end

        def aws_secret_access_key=(value)
          self['aws_secret_access_key'] = value
        end

        def credential_file
          self['credential_file']
        end

        def credential_file=(value)
          self['credential_file'] = value
        end

        def duration
          self['duration']
        end

        def duration=(value)
          self['duration'] = value
        end

        # @api private
        def load_file
          return {} unless File.exist?(@path)
          YAML.load(File.read(@path))
        end

        def mfa_device
          self['mfa_device']
        end

        def mfa_device=(value)
          self['mfa_device'] = value
        end

        def profile
          self['profile']
        end

        def profile=(value)
          self['profile'] = value
        end

        def region
          self['region']
        end

        def region=(value)
          self['region'] = value
        end

        def to_h
          @config
        end
      end
    end
  end
end
