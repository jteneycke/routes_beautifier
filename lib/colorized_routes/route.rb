#module ColorizedRoutes
  class Route
    # The route will hold all the information for the path, action name, etc

    def initialize verb, path, prefix, action
      @verb = verb
      @path = path
      @prefix = prefix
      @action = action
    end

    def display widths
      print "#{@verb.center(widths[:verb])}".light_red
      print " | ".light_white
      print "#{@path.ljust(widths[:path]).split('/').map{|p| p.light_blue}.join('/'.green)}"
      print " | ".light_white
      print "#{@prefix.ljust(widths[:prefix])}".yellow
      print " | ".light_white
      print "#{@action}\n".light_green
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