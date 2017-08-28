
module TSP
  class Location
    attr_accessor :visited
    attr_reader :name, :x, :y
    def initialize(name, x, y)
      @name = name
      @x = x
      @y = y
      @visited = false
    end

    def distance_to(location)
      x_dist = (@x - location.x).abs
      y_dist = (@y - location.y).abs

      Math::sqrt((x_dist ** 2) + (y_dist ** 2)).round
    end
  end
end
