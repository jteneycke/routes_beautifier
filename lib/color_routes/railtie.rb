module ColorRoutes
    class Railtie < Rails::Railtie
        rake_tasks do
            require '../color_routes.task'
        end
    end
end
