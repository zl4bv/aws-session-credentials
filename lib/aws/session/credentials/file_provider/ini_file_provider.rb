module Aws
  module Session
    module Credentials
      module FileProvider
        # Mixin to store configuration in an INI file
        module IniFileProvider
          def [](key)
            read[key.to_s]
          end

          def []=(key, value)
            ini_file = read
            ini_file[key.to_s] = value
            ini_file.save
          end

          # @api private
          # @return [IniFile]
          def read
            if File.exist?(path)
              IniFile.load(path)
            else
              IniFile.new(filename: path, encoding: 'UTF-8', permissions: 0600)
            end
          end
        end
      end
    end
  end
end
