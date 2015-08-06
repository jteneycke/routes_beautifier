desc 'Makes routes a little more pretty.'

task :colorized_routes => :environment do

  Rails.application.reload_routes!
  all_routes = Rails.application.routes.routes.to_a
  all_routes.reject! { |route| route.verb.nil? || route.path.spec.to_s == '/assets' }
  all_routes.select! { |route| ENV['CONTROLLER'].nil? || route.defaults[:controller].to_s == ENV['CONTROLLER'] }

  max_widths = {
    names: (all_routes.map { |route| route.name.to_s.length }.max),
    verbs: (6),
    paths: (all_routes.map { |route| route.path.spec.to_s.rstrip.length }.max),
    controllers: (all_routes.map { |route| route.defaults[:controller].to_s.length }.max),
    actions: (all_routes.map { |route| route.defaults[:action].to_s.length }.max)
  }
  puts "#{max_widths.inspect}".yellow

    all_routes.group_by {|route| route.defaults[:controller]}.each_value do |group|
        print "Controller: ".light_white
        puts "#{group.first.defaults[:controller].to_s}".cyan
        group.each do |route|
            # VERBS (GET/POST/DELETE/PATCH/ETC)
            print "#{route.verb.inspect.gsub(/^.{2}|.{2}$/, "").center(max_widths[:verbs])}".light_red
            print " | ".light_white
            # PATHS
            path = route.path.spec.to_s.gsub("(.:format)","")
            print "#{path.ljust(max_widths[:paths]).split('/').map{|p| p.light_yellow}.join('/'.red)}"

            print " | ".light_white

            # PATH NAMES
            print "#{route.name.to_s.ljust(max_widths[:names])}".light_blue
            print " | ".light_white

            # CONTROLLER ACTIONS
            print "#{route.defaults[:action].to_s}".light_green

            puts ""
        end

        puts ""
    end
end
