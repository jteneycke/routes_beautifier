module ColorRoutes
    class Railtie < Rails::Railtie
        railtie_name :color_routes

        rake_tasks do
          load "tasks/color_routes.task"
        end
    end
end
