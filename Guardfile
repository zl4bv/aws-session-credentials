guard :cucumber, all_on_start: false, cmd_additional_args: '--no-profile --color --format progress --strict' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})                      { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end
