require "color_routes/version"
require 'color_routes/railtie' if defined?(Rails)

module ColorRoutes
    def self.root
      File.expand_path '../..', __FILE__
    end
end
