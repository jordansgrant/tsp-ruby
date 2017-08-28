require_relative "./location.rb"

module TSP
  class Tour
    attr_accessor :route, :fitness, :distance
    def initialize(size = nil)
      @route = (size) ? Array.new(size, nil) : []
      @fitness = nil 
      @distance = nil
    end

    def get_fitness
      @fitness ||= 1.0 / get_total_distance  
    end

    def get_total_distance()
      @distance ||= @route.each_with_index.inject(0) do |dist, (loc,index)|
        dist + loc.distance_to((index + 1 < @route.length) ? @route[index + 1] : @route[0])
      end 
      @distance
    end



    #############################################
    #          Genetic Functions
    #############################################
    def mutate!(rate)
      @route.each_with_index do |location, index|
        if rand(0.0..1.0) < rate
          # get random index for swap
          random = (rand(0.0...1.0) * @route.length).round % @route.length
          @route[index], @route[random] = @route[random], @route[index]
        end 
      end

      @distance = nil
      @fitness = nil
    end
    ######## End Genetic Functions ##############

    #############################################
    #         Two Opt Functions
    #############################################
    
    # performs a transform operation for the Two Opt Algorithm
    # copies region from 0 to point1-1 and point2+1 to the end in order
    # copies region from point1 to point2 in reverse
    def two_opt_transform(point1, point2)
      new_tour = Tour.new(@route.length)
      clone_region_forward(new_tour, 0, point1 - 1)
      clone_region_reverse(new_tour, point1, point2)
      clone_region_forward(new_tour, point2 + 1, new_tour.length - 1)
      new_tour
    end

    # Clones the region between start_index and stop_index in order into
    # new_tour
    def clone_region_forward(new_tour, start_index, stop_index)
      new_tour[(start_index..stop_index)] = @route[(start_index..stop_index)]
    end

    # clones the region between start_index and stop_index in reverse into
    # new_tour
    def clone_region_reverse(new_tour, start_index, stop_index)
      new_tour[(start_index..stop_index)] = @route[(start_index..stop_index)].reverse
    end
    ######## End Two Opt Functions ##############

    def method_missing(method, *args)
      if (Array.instance_methods.include?(method) || Enumerable.instance_methods.include?(method))
        @route.send(method, *args)
      else
        super
      end
    end
  end
end
