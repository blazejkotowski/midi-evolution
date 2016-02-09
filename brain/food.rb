module Brain
  class Food < Base
    MAX_LIFETIME = 2000

    def initialize(world)
      super world
      @frames = 0
      @lifetime = Random.rand(MAX_LIFETIME)
      @body = Body::Food.new
    end

    def feed
      closest_distance = 100000
      closest = @@world.agents.first
      @@world.agents.each do |agent|
        dist = distance_to(agent)
        if closest_distance > dist
          closest = agent
          closest_distance = dist
        end
      end

      if closest_distance <= 3
        closest.eat(self)
        @@world.food -= [self]
      end
    end

    def disappear
      if @frames > @lifetime
        @@world.food -= [self]
      end 
    end

    def update
      @frames += 1
      disappear
      feed
    end
  end
end