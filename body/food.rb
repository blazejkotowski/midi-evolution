module Body
  class Food
    def initialize
      @image = Gosu::Image.new(File.absolute_path("resources/food.gif"))
    end

    def draw(x, y, angle)
      @image.draw_rot(x, y, 0, angle, 0, 0, 0.5, 0.5)
    end
  end
end