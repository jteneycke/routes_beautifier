class Controller
  # The controller will have many routes

  def initialize routes, name
    if name.include? "/"
      parts = name.split("/")
      @name = parts.last
      @namespaces = parts.take(parts.size - 1)
    else
      @name = name
      @namespaces = []
    end
    @routes = routes
  end

  def display widths, print_routes=true
    space_counter = 0
    if @namespaces.any?
      @namespaces.each do |ns|
        unless space_counter == 0
          print "#{Array(1..space_counter).map{|s| " "}.join}"
        end
        print "Namespace: ".light_white
        puts " #{ns} ".light_white.on_light_red.bold
        space_counter += 1
      end
    end
    unless space_counter == 0
      print "#{Array(1..space_counter).map{|s| " "}.join}"
    end
    print "Controller: ".light_white
    if @namespaces.any?
      print " #{@name} ".light_white.on_blue.bold
      print " => ".light_white
      puts " #{[@namespaces.join("/"),@name].join("/")} ".light_white.on_blue.bold
    else
      puts " #{@name} ".light_white.on_blue.bold
    end
    if print_routes
      @routes.each {|r| r.display(widths)}
    end

    puts ""
  end

  def name
    @name
  end

  def namespaces
    @namespaces
  end

  def routes
    @routes
  end

  def full_name
    dup_namespaces = namespaces.clone
    dup_namespaces.push name
    dup_namespaces.join("/")
  end

  def self.build_routes all_routes
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

    controllers
  end

  def self.search search_term, controllers
    if search_term.include?(" ")
      terms = search_term.split(" ").count
      search_term = search_term.split(" ").first
      puts "ColorizedRoutes only searches for the first term in a string (#{search_term})".red if terms > 1
    end

    found = 0
    searched = 0

    print "\n\r"
    print "FOUND: "
    print " 0 ".white.on_blue
    print " | SEARCHED: "
    print " 0 ".white.on_green

    flagged_controllers = Hash.new

    controllers.each do |controller|
      if controller.full_name.include?(search_term)
        flagged_controllers[controller.full_name] = controller.routes
        print "FOUND: "
        print " #{found += 1} ".white.on_blue
        print " | SEARCHED: "
        print " #{searched += 1} ".white.on_green
        print "\r"
        sleep 1
      else
        flagged_routes = []
        controller.routes.each do |route|
          if route.contains_search_term(search_term)
            flagged_routes.push route
            print "\r"
            print "FOUND: "
            print " #{found += 1} ".white.on_blue
            print " | SEARCHED: "
            print " #{searched += 1} ".white.on_green
          end
          sleep 1
        end
        flagged_controllers[controller.full_name] = flagged_routes if flagged_routes.any?
      end
    end
    puts ""
  end
end