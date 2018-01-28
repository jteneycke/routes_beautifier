desc 'Makes routes a little more pretty.'


task :routes do
  require 'routes_beautifier/controller'
  require 'routes_beautifier/route'
  require 'colorize'
  require 'colorized_string'

  Rake::Task['routes'].clear
  Rails.application.reload_routes!

  all_routes = Rails.application.routes.routes.to_a

  all_routes.reject! do |route|
    route.verb.nil? || route.path.spec.to_s == '/assets'
  end

  all_routes.select! do |route|
    ENV['CONTROLLER'].nil? || route.defaults[:controller].to_s == ENV['CONTROLLER']
  end

  controllers = []
  widths      = nil

  all_routes.group_by do |route|
    route.defaults[:controller]
  end.each_value do |group|
    routes = []
    group.each do |route|
      routes.push Route.new(
                      route.verb.inspect.gsub(/^.{2}|.{2}$/, ""),
                      route.path.spec.to_s.gsub("(.:format)",""),
                      route.name.to_s,
                      route.defaults[:action].to_s
                  )
    end

    widths = Route.max_widths(routes,widths)

    controllers.push(Controller.new(routes, group.first.defaults[:controller].to_s))
  end

  controllers.each {|c| c.display(widths)}
end

task :routes_beautifier => :environment do

end
