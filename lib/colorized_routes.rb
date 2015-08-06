require "colorized_routes/version"
require 'colorized_routes/railtie' if defined?(Rails)

module ColorizedRoutes
    def self.root
      File.expand_path '../..', __FILE__
    end
end
