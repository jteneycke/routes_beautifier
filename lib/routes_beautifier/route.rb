class Route
  # The route will hold all the information for the path, action name, etc

  def initialize(verb, path, prefix, action)
    @verb   = verb
    @path   = path
    @prefix = prefix
    @action = action
  end

  def display(widths)
    paths = @path.ljust(widths[:path])
                 .split('/')
                 .map do |path|
                  if path.start_with?(":")
                    path.light_magenta
                  else
                    path.blue
                  end
                end.join('/'.green)

    prefix = @prefix.ljust(widths[:prefix])

    print "#{@verb.center(20)}".yellow
    print "#{paths}"
    print "#{prefix}".yellow
    print "#{@action}".green
    puts ""
  end

  def self.max_widths(routes, existing_widths = nil)
    types  = [:verb,:path,:prefix,:action]

    widths = if existing_widths.nil?
               Hash[types.map{|t| [t,0]}]
             else
               existing_widths
             end

    routes.each do |route|
      types.each do |type|
        widths[type] = if widths[type] < route.send(type).length
                         route.send(type).length
                       else
                         widths[type]
                       end
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
