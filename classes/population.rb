require_relative "./location.rb"
require_relative "./tour.rb"
require_relative "./tsp.rb"

module TSP
  class Population
    attr_accessor :tour_list
    def initialize(size, locations = nil, seed_algo = :nearest_neighbor)
      @tour_list = []
      size.times do 
        @tour_list << TSP.send(seed_algo, locations) 
        print "\rSeeded #{@tour_list.length} Tours of #{size}"
      end if locations
    end

    # get the fittest Tour in the Population
    def get_fittest
      @tour_list.max { |first, second| first.get_fitness <=> second.get_fitness }
    end

    # create a new population that is the result of crossover and mutation
    # return the new population
    # note: the fittest of the old population is added to the new population
    #       to avoid regression
    def evolve(crossover_size, rate = 0.015)
      new_pop = Population.new(0)
      new_pop.tour_list <<  self.get_fittest 

      (@tour_list.length - 1).times do 
        parent1 = crossover_candidate(crossover_size)
        parent2 = crossover_candidate(crossover_size)

        new_pop.tour_list << crossover(parent1, parent2)
      end

      new_pop.tour_list.each { |tour| tour.mutate!(rate) unless tour.equal? new_pop.first }
      new_pop
    end

    # 2 parents "breed" by copying a sequence of elements from parent1
    # into child, then filling in the missing spaces
    def crossover(parent1, parent2)
      child = Tour.new(parent1.route.length) 

      rand1 = (rand(0.0...1.0) * child.route.length).round % child.route.length
      rand2 = (rand(0.0...1.0) * child.route.length).round % child.route.length

      if rand1 <= rand2
        child[rand1..rand2] = parent1[rand1..rand2] 
      else
        child[rand2..rand1] = parent1[rand2..rand1]
      end

      # fill in the ramaining gaps with locations that were not taken from parent1
      (parent2 - child).each do |location|
        index = child.find_index(nil)
        child[index] = location
      end

      child
    end

    def method_missing(method, *args)
      if (Array.instance_methods.include?(method) || Enumerable.instance_methods.include?(method))
        @tour_list.send(method, *args)
      else
        super
      end
    end

    private
    # get the fittest of a random sampling of the population
    def crossover_candidate(n)
      candidatePop = Population.new(0)
      candidatePop.tour_list = @tour_list.sample(n)
      candidatePop.get_fittest
    end

  end

end
