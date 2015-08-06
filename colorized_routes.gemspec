# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'colorized_routes/version'

Gem::Specification.new do |spec|
  spec.name          = "colorized_routes"
  spec.version       = ColorizedRoutes::VERSION
  spec.authors       = ["Josh Tate"]
  spec.email         = ["joshtate04@me.com"]

  spec.summary       = "Colorize your Rails routes"
  spec.description   = "Throw some color into your rake routes task. Makes your routes more readable and better organized."
  spec.homepage      = "http://github.com/joshtate04/colorized_routes"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "colorize", '~> 0.7'
end
