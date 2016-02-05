module Brain
  class Agent
    @@world = nil

    def initialize(world)
      @world = world

      @body = Body::Agent.new

      @x = @world.random_x
      @y = @world.random_y
    end

    def mutation
      Agent.new(@world)
    end

    def draw
      @body.draw(@x, @y)
    end
  end
end