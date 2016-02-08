module Brain
  class Agent < Base

    def initialize(world)
      super world
      @angle = @@world.random_angle
      @body = Body::Agent.new
    end

    def mutation
      Agent.new(@@world)
    end

  end
end