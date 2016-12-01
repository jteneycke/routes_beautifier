require "routes_beautifier/version"
require 'routes_beautifier/railtie' if defined?(Rails)
require 'colorize'
require 'colorize_string'

module RoutesBeautifier
    def self.root
      File.expand_path '../..', __FILE__
    end
end
