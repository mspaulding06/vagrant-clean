# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clean/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-clean"
  spec.version       = VagrantPlugins::Clean::VERSION
  spec.authors       = ["Matt Spaulding"]
  spec.email         = ["mspaulding06@gmail.com"]
  spec.description   = %q{Command to destroy all vagrant resources}
  spec.summary       = %q{Command to destroy all vagrant resources}
  spec.homepage      = "https://github.com/mspaulding06/vagrant-clean"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
