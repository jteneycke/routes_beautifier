module ColorRoutes
    class Railtie < Rails::Railtie
        railtie_name :color_routes

        rake_tasks do
          load "#{ColorRoutes.root}/lib/color_routes/rails/tasks/color_routes.rake"
        end
    end
end
