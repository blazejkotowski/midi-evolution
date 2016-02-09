module Brain
  class Base
    @@world = nil

    attr_accessor :angle, :geometry

    def initialize(world)
      @@world = world

      xx = @@world.random_x
      yy = @@world.random_y
      while @@world.occupied? xx, yy
        xy = @@world.random_x
        yy = @@world.random_y
      end
      @geometry = Geometry::Point.new(xx, yy)

      # @angle = Random.rand(360)
      @angle = 90
    end

    def draw
      @body.draw(x, y, @angle)
    end

    %w(x y).each do |param|
      define_method param do
        @geometry.send(param)
      end
    end

    def distance_to(another)
      @geometry.distance_to(another)
    end

    def angle_to(another)
      dy = y - another.y
      dx = x - another.x
      theta = Math.atan2(dx, dy)
      angle = theta * 180 / Math::PI
      angle += 360 if angle < 0
      angle*-1
    end
  end
end