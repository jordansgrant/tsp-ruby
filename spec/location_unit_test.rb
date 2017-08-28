require_relative "../classes/location.rb"
require_relative "./spec_helper.rb"

RSpec.describe TSP::Location do

  before(:example) do 
    @locations = SpecHelper::build_locations
  end

  it "is properly filled by contructor when created" do
    expect(@locations[0].name).to eq(0)
    expect(@locations[0].x).to eq(200)
    expect(@locations[0].y).to eq(800)

    expect(@locations[1].name).to eq(1)
    expect(@locations[1].x).to eq(400)
    expect(@locations[1].y).to eq(600)
  
    expect(@locations[2].name).to eq(2)
    expect(@locations[2].x).to eq(700)
    expect(@locations[2].y).to eq(300)
  end

  context "When calculating distance to another Locatoion" do
    it "calculates the correct distance between two Locations" do
    	x_dist = (@locations[0].x - @locations[1].x).abs
        y_dist = (@locations[0].y - @locations[1].y).abs

        distance = Math::sqrt((x_dist ** 2) + (y_dist ** 2)).round
		expect(@locations[0].distance_to(@locations[1])).to eq(distance) 
    end

    it "calculates the same distance as the second location does to it" do
      expect(@locations[0].distance_to(@locations[1])).to eq(@locations[1].distance_to(@locations[0]))
    end
  end
end
