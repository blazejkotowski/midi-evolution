module Brain
  class Food < Base
    def initialize(world)
      super world
      @body = Body::Food.new
    end
  end
end