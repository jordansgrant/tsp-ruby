require_relative "../classes/location.rb"
require_relative "../classes/tour.rb"
require_relative "./spec_helper.rb"

RSpec.describe TSP::Tour do
  before(:example) do
    @locations = SpecHelper::build_locations
    @tour = TSP::Tour.new(@locations.length)
  end 

  context "When initialized" do
    it "should be of specified length" do
      expect(@tour.route.length).to eq(@locations.length)
    end

    it "should be empty if size not specified" do
      expect(TSP::Tour.new.route).to be_empty
    end

    it "should be initialized to nil" do
      @tour.each { |loc| expect(loc).to eq(nil) }
      expect(@tour.fitness).to eq(nil)
      expect(@tour.distance).to eq(nil)
    end
  end

  it "calculates the correct distance" do
    @tour.route = @locations

    distance = 0
    for i in (0..@locations.length-1) do
      next_index = (i + 1 < @locations.length) ? i + 1 : 0
      distance += @locations[i].distance_to(@locations[next_index])
    end

    expect(@tour.get_total_distance).to eq(distance)
  end 

  it "gets the same fitness on multiple calls" do
    @tour.route = @locations
    fitness = @tour.get_fitness
    expect(@tour.get_fitness).to be_within(0.001).of(fitness)
  end

  it "has different different distance and fitness after mutation" do
    @tour.route = @locations
    distance = @tour.get_total_distance
    fitness = @tour.get_fitness

    @tour.mutate!(0.5)

    expect(@tour.get_total_distance).not_to eq(distance)
    expect(@tour.get_fitness).not_to eq(fitness)
  end

end
