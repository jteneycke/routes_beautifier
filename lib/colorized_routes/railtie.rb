module ColorizedRoutes
    class Railtie < Rails::Railtie
        railtie_name :colorized_routes

        rake_tasks do
          load "#{ColorizedRoutes.root}/lib/colorized_routes/rails/tasks/colorized_routes.rake"
        end
    end
end
