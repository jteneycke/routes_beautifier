require 'awesome_print'
require 'colorize'
require 'colorized_string'

desc 'Makes routes a little more pretty.'
task :routes do

  Rake::Task['routes'].clear

  Rails.application.reload_routes!

  Rails
    .application
    .routes
    .routes
    .to_a
    .reject do |route|
      route.verb.nil? || route.path.spec.to_s == '/assets'
    end
    .select do |route|
      ENV['CONTROLLER'].nil? || (route.defaults[:controller].to_s == ENV['CONTROLLER'])
    end
    .group_by do |route|
      route.defaults[:controller]
    end.each_value do |group|
      group.each do |route|
        route = {
          verb:   route.verb.inspect.gsub(/^.{2}|.{2}$/, ""),
          path:   route.path.spec.to_s.gsub("(.:format)",""),
          prefix: route.name.to_s,
          action: route.defaults[:action].to_s
        }
        ap(route)
      end
    end

end
