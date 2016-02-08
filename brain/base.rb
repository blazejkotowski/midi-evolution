module Brain
  class Base
    @@world = nil

    attr_accessor :x, :y, :angle

    def initialize(world)
      @@world = world

      print "base #{@@world}\n"
      @x = @@world.random_x
      @y = @@world.random_y
      while @@world.occupied @x, @y
        @x = @@world.random_x
        @y = @@world.random_y
      end
      @angle = Random.rand(360)
    end

    def draw
      @body.draw(@x, @y, @angle)
    end
  end
end