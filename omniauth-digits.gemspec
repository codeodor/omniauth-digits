# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/strategies/digits/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-digits"
  spec.version       = Omniauth::Digits::VERSION
  spec.authors       = ["Sammy Larbi"]
  spec.email         = ["sam@codeodor.com"]

  spec.summary       = %q{An omniauth strategy for Fabric.io Digits}
  spec.homepage      = "https://github.com/codeodor/omniauth-digits"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.0"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_dependency 'omniauth', '~> 1.0'
end
