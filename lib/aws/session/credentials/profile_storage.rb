module Aws
  module Session
    module Credentials
      # Mixin to store profiles
      module ProfileStorage
        # @param [Thor::Shell] shell
        def print_profiles(shell)
          profiles_table = profiles.map do |name, prof|
            cols = [name]
            cols << Time.at(prof['expiry']) if prof['expiry']
            cols
          end
          shell.print_table(profiles_table.unshift(%w(Name Expiry)))
        end

        # @return [Hash<String,Profile>]
        def profiles
          prfs = {}
          profiles_hash.each do |name, options|
            prfs[name] = Profile.new(options)
          end
          prfs
        end

        # @param [Hash<String,Profile>] prfs
        def profiles=(prfs)
          hash = {}
          prfs.each do |name, prof|
            hash[name] = prof.to_h
          end
          self.profiles_hash = hash
        end

        # @param [String] name
        # @return [Profile]
        def profile(name)
          profiles[name]
        end

        # @param [String] name
        # @param [Profile] prof
        def set_profile(name, prof)
          profs = profiles.dup
          profs[name] = prof
          self.profiles = profs
          prof
        end
      end
    end
  end
end
