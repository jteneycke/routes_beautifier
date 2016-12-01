require "routes_beautifier/version"
require 'routes_beautifier/railtie' if defined?(Rails)

module RoutesBeautifier
    def self.root
      File.expand_path '../..', __FILE__
    end
end
