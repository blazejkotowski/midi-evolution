module Brain
  class Food < Base
    def initialize(world)
      super world
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
  end
end