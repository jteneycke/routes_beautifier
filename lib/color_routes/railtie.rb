module ColorRoutes
    class Railtie < Rails::Railtie
        rake_tasks do
            require 'lib/color_routes/color_routes.task'
        end
    end
end
