module ColorRoutes
    class Railtie < Rails::Railtie
        railtie_name :color_routes

        rake_tasks do
          load "#{ColorRoutes.root}/tasks/color_routes.rake"
        end
    end
end
