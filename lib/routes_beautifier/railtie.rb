module RoutesBeautifier
    class Railtie < Rails::Railtie
        railtie_name :routes_beautifier

        rake_tasks do
          load "#{RoutesBeautifier.root}/lib/routes_beautifier/rails/tasks/routes_beautifier.rake"
        end
    end
end
