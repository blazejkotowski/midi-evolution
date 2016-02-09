module Brain
  class Agent < Base
    TRANSPOSITION_SPEED = 1
    ANGLE_SPEED = 5

    attr_accessor :speed

    def initialize(world)
      super world
      @body = Body::Agent.new
    end

    def mutation
      Agent.new(@@world)
    end

    def move
      closest_distance = 100000
      closest = @@world.food.first
      @@world.food.each do |food|
        dist = distance_to(food)
        if closest_distance > dist
          closest = food
          closest_distance = dist
        end
      end
      if closest
        # closest = Geometry::Point.new(@@world.width/2, @@world.height/2) unless closest
        desired_angle = angle_to(closest)
        update_angle(desired_angle)
        update_position
      end
    end

    def eat(food)
    end

    private

      def update_position
        dx = TRANSPOSITION_SPEED * Math.sin(@angle * Math::PI / 180)
        dy = TRANSPOSITION_SPEED * Math.cos(@angle * Math::PI / 180)
        if @@world.reachable?(@geometry.x + dx, @geometry.y + dy, self)
          @geometry.x += dx
          @geometry.y -= dy
        end
      end

      def update_angle(desired_angle)
        d_angle = 0
        if desired_angle > @angle
          if desired_angle - @angle > ANGLE_SPEED
            d_angle = ANGLE_SPEED
          else
            d_angle = desired_angle - @angle
          end
        elsif desired_angle < @angle
          if @angle - desired_angle > ANGLE_SPEED
            d_angle = -ANGLE_SPEED
          else
            d_angle = desired_angle - @angle
          end
        end
        @angle += d_angle
      end
  end
end