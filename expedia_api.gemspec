# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expedia_api/version'

Gem::Specification.new do |spec|
  spec.name          = "expedia_api"
  spec.version       = ExpediaApi::VERSION
  spec.authors       = ["Hendrik Kleinwaechter"]
  spec.email         = ["hendrik.kleinwaechter@gmail.com"]

  spec.description       = "Expediacom is a lightweight flexible Ruby SDK for the official Expedia.com API"
  spec.summary           = "Wrapper for the Expedia.com API"
  spec.homepage          = "https://github.com/hendricius/expedia_api"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency(%q<faraday>,       ["~> 0.8"])
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "money", '~> 6'

end
