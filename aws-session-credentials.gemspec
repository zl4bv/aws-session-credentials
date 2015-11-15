# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws/session/credentials/version'

Gem::Specification.new do |spec|
  spec.name          = 'aws-session-credentials'
  spec.version       = Aws::Session::Credentials::VERSION
  spec.authors       = ['Ben Vidulich']
  spec.email         = ['ben@vidulich.co.nz']

  spec.summary       = %q{Command-line tool to generate AWS session credentials.}
  spec.description   = %q{Command-line tool to generate AWS session credentials.}
  spec.homepage      = 'https://github.com/zl4bv/aws-session-credentials'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'aws-sdk', '~> 2.1'
  spec.add_runtime_dependency 'inifile', '~> 3.0'
  spec.add_runtime_dependency 'smartcard'
  spec.add_runtime_dependency 'thor', '~> 0.19'
  spec.add_runtime_dependency 'yubioath', '~> 1.0.0'
end
