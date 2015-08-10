desc 'Makes routes a little more pretty.'


task :routes do
  require 'colorized_routes/controller'
  require 'colorized_routes/route'
  require 'optparse'

  puts "                                                              ".light_white.on_blue
  puts "                       COLORIZED ROUTES                       ".light_white.on_blue
  puts "    github: https://github.com/joshtate04/colorized_routes    ".light_white.on_blue
  puts "                                                              ".light_white.on_blue
  puts ""


  Rake::Task['routes'].clear
  Rails.application.reload_routes!
  controllers = Controller.build_routes(Rails.application.routes.routes.to_a)

  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: rake routes [search]"
    opts.on("-s", "--search [SEARCH_TERM]") do |search|
      search_term.search = search
    end
  end.parse!

  if search_term.present?
    search_results = Controller.search(search_term, controllers)
  else
    controllers.each {|c| c.display(widths)}
  end
end
