require_relative "./integer.rb"
require_relative "./tour.rb"
require_relative "./location.rb"

module TSP

  # Performs genetic algorithm on the population of Tours
  # Returns the fittest Tour after n generations
  def self.genetic(locations, opts)
    population = Population.new(opts[:pop_size], locations, opts[:seed_algo]) 
    puts "\nInitial Tour Size: #{population.get_fittest.get_total_distance}\n"
  
    (1..opts[:generations]).each do |i|
      population = population.evolve(opts[:crossover], opts[:rate])
      print "\rCompleted Generation #{i} of #{opts[:generations]}"
    end   
    population.get_fittest
  end

  # Performs a Two Opt algorithm on the best of the seeded population
  # Returns the tour after "generations" rounds of Two Opt
  def self.two_opt(locations, opts)
    population = Population.new(opts[:pop_size], locations, opts[:seed_algo]) 
    puts "\nInitial Tour Size: #{population.get_fittest.get_total_distance}\n"

    best = population.get_fittest

    (1..opts[:generations]).each do |i|
      best_distance = best.get_total_distance
      (0..best.length-1).to_a.combination(2) do |i1, i2|
        new = best.two_opt_transform(i1, i2)
        if new.get_total_distance < best_distance
          best = new
          break
        end
        print("\rCompleted Two-Opt Rount #{i} of #{opts[:generations]}")
      end
    end
    best
  end

  def self.nearest_neighbor(locations)
    # copy so we can mark locations as visited 
    nnList = locations.clone
    tour = Tour.new
    # get a random index in locations as a starting point
    rand_start = (rand(0.0..1.0) * locations.length).round % locations.length

    # assign starting location in tour
    tour.route << nnList[rand_start]
    nnList.delete_at(rand_start)

    # store index of nearest neighbor when found
    nn_index = -1
    # store distance to current nearest neighbor
    min_dist = Integer::MAX

    loop do
      dist = nil

      nnList.each_with_index do |location, index|
        dist = tour.last.distance_to(location)
        min_dist, nn_index = dist, index if dist < min_dist 
      end

      abort("Index to nearest neighbor not found, something went wrong") if nn_index.equal? -1
      tour.route << nnList[nn_index]
      nnList.delete_at(nn_index)

      min_dist = Integer::MAX
      nn_index = -1

      break if nnList.empty?
    end

    tour
  end

  def self.random_tour(locations)
    tour = Tour.new(locations.length)
    tour.route = locations.clone.sample(locations.length)
    tour
  end

  def self.read_input(infile)
    locations = []

    File.foreach(infile) do |line|
      name, x, y = line.split(/\s+/)
      
      unless name and x and y 
        abort("Invalid input file, expected line format ""name x y""")
      end

      locations << Location.new(name, x.to_i, y.to_i)
    end
    locations
  end

end

