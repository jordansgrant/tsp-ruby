require_relative "../classes/population.rb"
require_relative "./spec_helper.rb"


RSpec.describe TSP::Population do

  before(:example) do
    @locations = SpecHelper::build_locations
    @population =  TSP::Population.new(100, @locations) 
  end 

  context "On initialization" do
    it "is uninitialized when no locations are given" do
      expect(TSP::Population.new(10).tour_list).to be_empty
    end

    it "is populated with tours if locations are given" do
      expect(@population.tour_list).not_to be_empty
    end
  end

  it "should return fittest individual in population" do
    @population.get_fittest
  end
end

