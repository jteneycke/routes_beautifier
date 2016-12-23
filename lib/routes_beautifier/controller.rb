#module RoutesBeautifier
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
          print "Namespace: ".white
          puts " #{ns} ".white.light_green
          space_counter += 1
        end
      end
      unless space_counter == 0
        print "#{Array(1..space_counter).map{|s| " "}.join}"
      end
      print "Controller: ".white
      if @namespaces.any?
        print " #{@name} ".white.blue
        print " => ".white
        puts " #{[@namespaces.join("/"),@name].join("/")} ".white.blue
      else
        puts " #{@name} ".white.blue
      end
      @routes.each {|r| r.display(widths)}

      puts ""
    end
  end
#end
