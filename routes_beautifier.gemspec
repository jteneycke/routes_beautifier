# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'routes_beautifier/version'

Gem::Specification.new do |spec|
  spec.name          = "routes_beautifier"
  spec.version       = RoutesBeautifier::VERSION
  spec.authors       = ["Kyle Beaulieu"]
  spec.email         = ["kyle.beaulieu@gmail.com"]

  spec.summary       = "Beautify your routesS"
  spec.description   = "Enjoy easier to read routes!"
  spec.homepage      = "https://github.com/kbeaulieu802/routes_beautifier"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "colorize", '~> 0.7'
  spec.add_dependency "awesome_print"
end
