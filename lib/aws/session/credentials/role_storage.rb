module Aws
  module Session
    module Credentials
      # Mixin to store roles
      module RoleStorage
        # @return [Hash<String,Role>]
        def roles
          rls = {}
          roles_hash.each do |name, options|
            rls[name] = Role.new(options)
          end
          rls
        end

        # @param [Hash<String,Role>] rls
        def roles=(rls)
          hash = {}
          rls.each do |name, rl|
            hash[name] = rl.to_h
          end
          self.roles_hash = hash
        end

        # @param [String] name
        # @return [Role]
        def role(name)
          roles[name]
        end

        # @param [String] name
        # @param [Role] rl
        def set_role(name, rl)
          rls = roles.dup
          rls[name] = rl
          self.roles = rls
          rl
        end
      end
    end
  end
end
