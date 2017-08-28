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

    def method_missing(method, *args)
      if (Array.instance_methods.include?(method) || Enumerable.instance_methods.include?(method))
        @route.send(method, *args)
      else
        super
      end
    end
  end
end
