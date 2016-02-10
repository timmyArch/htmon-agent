# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'htmon/agent/version'

Gem::Specification.new do |spec|
  spec.name          = "htmon-agent"
  spec.version       = Htmon::Agent::VERSION
  spec.authors       = ["Tim Foerster"]
  spec.email         = ["github@mailserver.1n3t.de"]

  spec.summary       = %q{HTTP Monitoring agent.}
  spec.homepage      = "https://github.com/timmyArch/htmon-agent"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  
  spec.add_dependency "rest-client"
  spec.add_dependency "activesupport"
end
