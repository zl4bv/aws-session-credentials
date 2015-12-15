module Aws
  module Session
    module Credentials
      module FileProvider
        # Mixin to store configuration in a YAML file
        module YamlFileProvider
          def [](key)
            read[key]
          end

          def []=(key, value)
            hash = read.dup
            hash[key] = value
            write(hash)
          end

          # @api private
          # @return [Hash]
          def read
            return {} unless File.exist?(path)
            YAML.load(File.read(path)).deep_symbolize_keys
          end

          # @api private
          # @param [Hash] hash
          def write(hash)
            hsh = hash.deep_stringify_keys
            File.open(path, 'w', 0600) { |file| file.write(YAML.dump(hsh)) }
          end
        end
      end
    end
  end
end
