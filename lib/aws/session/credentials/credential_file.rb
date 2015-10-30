module Aws
  module Session
    module Credentials
      # AWS credentials file. Usually located on disk at +~/.aws/credentials+.
      class CredentialFile
        # @param [String] path location of credentials file on disk
        # @param [IniFile] ini_file
        def initialize(path = '~/.aws/credentials', ini_file = nil)
          @path = File.expand_path(path)
          @ini_file = ini_file || init_ini_file
        end

        # @api private
        def init_ini_file
          if File.exist?(@path)
            IniFile.load(@path)
          else
            path_dir = File.dirname(@path)
            FileUtils.mkdir_p(path_dir) unless File.exist?(path_dir)
            IniFile.new(filename: @path, encoding: 'UTF-8') 
          end
        end

        # Sets credentials for provided profile.
        #
        # Overrides provided options if they already exist for the provided
        # profile. Does not override options if they are not provided. Set an
        # option to +nil+ to explicitly unset an existing option.
        # @param [String] profile name of profile to set credentials for
        # @param [Hash] options settings to set
        # @option options [String] :access_key_id Access key
        # @option options [String] :secret_access_key Secret key
        # @option options [String] :session_token Session token
        def set_credentials(profile, options = {})
          @ini_file[profile] = @ini_file[profile].merge(options)
          @ini_file.write
        end
      end
    end
  end
end
