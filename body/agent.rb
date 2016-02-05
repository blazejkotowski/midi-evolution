module Body
  class Agent
    def initialize
      @image = Gosu::Image.new(File.absolute_path("resources/agent.gif"))
    end

    def draw(x, y)
      @image.draw_rot(x, y, 10, 0)
    end
  end
end