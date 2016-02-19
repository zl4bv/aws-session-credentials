require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new(:unit) do |task|
    task.pattern = Dir.glob('spec/unit/**/*_spec.rb')
  end

  RSpec::Core::RakeTask.new(:integration) do |task|
    task.pattern = Dir.glob('spec/integration/**/*_spec.rb')
  end
end

require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |task|
  task.cucumber_opts = 'features --format pretty'
end

task :default => ['spec:unit', 'spec:integration']
