# Main entry point to TSP Main
# 
require          "optparse"
require_relative "./classes/population.rb"
require_relative "./classes/tsp_parse.rb"

options = TSP::TspParser.parse(ARGV)

locations = TSP::read_input options[:infile]

best_tour = TSP.send(options[:algo], locations, options).get_fittest

puts "\nFinal Distance: #{best_tour.get_total_distance}"
puts "Best Route:"
best_tour.route.each { |location| puts location.name }
