module ColorizedRoutes
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

    def display
      space_counter = 0
      if @namespaces.any?
        @namespaces.each do |ns|
          print "#{Array(0..space_counter).map{|s| " "}}"
          print "Namespace: ".light_white
          puts " #{ns} ".light_white.on_light_red.bold
          space_counter += 1
        end
      end
      print "#{Array(0..space_counter).map{|s| " "}}"
      print "Controller: ".light_white
      puts " #{name} ".light_white.on_blue.bold
    end
  end
end