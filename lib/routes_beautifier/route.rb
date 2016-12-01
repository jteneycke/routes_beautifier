#module RoutesBeautifier
  class Route
    # The route will hold all the information for the path, action name, etc

    def initialize verb, path, prefix, action
      @verb = verb
      @path = path
      @prefix = prefix
      @action = action
    end

    def display widths
      print "#{@verb.center()}".red
      print " | ".white
      print "#{@path.ljust(widths[:path]).split('/').map{|p| p.blue}.join('/'.green)}"
      print " | ".white
      print "#{@prefix.ljust(widths[:prefix])}".yellow
      print " | ".white
      print "#{@action}".green
      puts ""
    end

    def self.max_widths routes, existing_widths = nil
      types = [:verb,:path,:prefix,:action]
      widths = existing_widths.nil? ? Hash[types.map{|t| [t,0]}] : existing_widths

      routes.each do |route|
        types.each do |type|
          widths[type] = widths[type] < route.send(type).length ? route.send(type).length : widths[type]
        end
      end
      widths
    end

    def verb
      @verb
    end

    def path
      @path
    end

    def prefix
      @prefix
    end

    def action
      @action
    end
  end
#end
