#module ColorizedRoutes
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

    def display widths
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
      @routes.each {|r| r.display(widths)}

      puts ""
    end
  end
#end