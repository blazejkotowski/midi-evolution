require 'gosu'

class World < Gosu::Window
  @@world = nil
  def self.instance
    @@world
  end

  def initialize(agents_number, food_number, width = 800, height = 800)
    super width, height

    @agents = @food = []

    @agents_number = agents_number
    @food_number = food_number
    @width = width
    @height = height
    self.caption = ""

    @background = Gosu::Image.new(File.absolute_path("resources/background.png"), tileable: true)

    # Agents that survived
    @survivors = (1..2).map { Brain::Agent.new self }

    # Alive agents
    @agents = [] + @survivors

    generate_agents

    # Food

    # Existing food
    @food = []
    generate_food
  end

  def update
    %w(agents food).each do |entity|
      instance_variable_get("@#{entity}").each do |agent|
        agent.x += Random.rand(3) - 1
        agent.y += Random.rand(3) - 1
        agent.angle += Random.rand(11) - 5 
      end
    end
  end

  def draw
    @background.draw(0, 0, 0)
    @agents.each { |a| a.draw }
    @food.each { |f| f.draw }
  end

  def random_x
    x = Random.rand(width)
    x
  end

  def random_y
    y = Random.rand(height)
    y 
  end

  def occupied(x, y)
    is = false
    %w(agents food).each do |var|
      instance_variable_get("@#{var}").each do |entity|
        is = true if 
          entity.x >= x - 10 && entity.x <= x + 10 &&
          entity.y >= y - 10 && entity.y <= y + 10
      end
    end
    is
  end

  def random_angle
    Random.rand(360)
  end

  private
    def generate_agents
      # Summons new agents to life mutating the collection of survivors
      (@agents_number-@survivors.size).times do
        @survivors.rotate!
        @agents << @survivors.first.mutation
      end
    end

    def generate_food
      @food_number.times do
        @food << Brain::Food.new(self)
      end
    end
end