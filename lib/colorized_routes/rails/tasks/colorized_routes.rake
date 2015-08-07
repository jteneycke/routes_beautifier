desc 'Makes routes a little more pretty.'


task :routes do
  require 'colorized_routes/controller'
  require 'colorized_routes/route'
  puts "                                                              ".light_white.on_blue
  puts "                       COLORIZED ROUTES                       ".light_white.on_blue
  puts "    github: https://github.com/joshtate04/colorized_routes    ".light_white.on_blue
  puts "                                                              ".light_white.on_blue
  puts ""


  Rake::Task['routes'].clear
  Rails.application.reload_routes!
  all_routes = Rails.application.routes.routes.to_a
  all_routes.reject! { |route| route.verb.nil? || route.path.spec.to_s == '/assets' }
  all_routes.select! { |route| ENV['CONTROLLER'].nil? || route.defaults[:controller].to_s == ENV['CONTROLLER'] }


  controllers = []
  widths = nil

  all_routes.group_by {|route| route.defaults[:controller]}.each_value do |group|
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
    controllers.push(Controller.new(routes,group.first.defaults[:controller].to_s))
  end

  controllers.each {|c| c.display(widths)}
end

task :colorized_routes => :environment do

end
