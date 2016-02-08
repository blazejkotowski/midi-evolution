module Body
  class Agent
    def initialize
      @image = Gosu::Image.new(File.absolute_path("resources/agent.gif"))
    end

    def draw(x, y, angle)
      @image.draw_rot(x, y, 0, angle, 0, 0, 0.3, 0.5)
    end
  end
end