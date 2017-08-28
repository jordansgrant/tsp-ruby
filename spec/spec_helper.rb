require_relative "../classes/location.rb"

module SpecHelper

  def self.build_locations                                          
	locations = []                                             
	locations << TSP::Location.new(0, 200, 800)                     
	locations << TSP::Location.new(1, 400, 600)                     
	locations << TSP::Location.new(2, 700, 300)
	locations << TSP::Location.new(3, 4000, 1000)
    locations << TSP::Location.new(4, 1200, 300)
    locations << TSP::Location.new(5, 200, 5)                     
  end

end
