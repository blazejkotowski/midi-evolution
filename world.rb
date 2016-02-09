require 'gosu'
require 'geometry'

class World < Gosu::Window
  FOOD_FREQUENCY = 250
  attr_accessor :agents, :food 

  @@world = nil
  def self.instance
    @@world
  end

  def initialize(agents_number, food_number, width = 800, height = 800)
    super width, height

    @frames = 0

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

    # Existing food
    @food = []
    generate_food
  end

  def update
    (@food + @agents).each do |piece|
      new_x = piece.geometry.x + Random.rand(11) - 5
      new_y = piece.geometry.y + Random.rand(11) - 5
      if reachable?(new_x, new_y)
        piece.geometry.x = new_x
        piece.geometry.y = new_y
      end
    end

    @food.each do |piece|
      piece.update
    end

    @agents.each do |agent|
      agent.move
    end

    @frames += 1
    if @frames >= FOOD_FREQUENCY
      @frames = 0
      generate_food
    end
  end

  def draw
    @background.draw(0, 0, 0)
    @agents.each { |a| a.draw }
    @food.each { |f| f.draw }
  end

  def random_x
    Random.rand(width)
  end

  def random_y
    Random.rand(height)
  end

  def occupied?(x, y, excluded = nil)
    is = false
    %w(agents food).each do |var|
      instance_variable_get("@#{var}").each do |entity|
        unless entity == excluded
          is = true if 
            entity.x >= x - 10 && entity.x <= x + 10 &&
            entity.y >= y - 10 && entity.y <= y + 10
        end
      end
    end
    is
  end

  def on_map?(x, y)
    x >= 0 && y >= 0 && x <= @width && y <= @height 
  end

  def reachable?(x, y, excluded = nil)
    # result = true
    # [x-10, x+10].each do |xx|
    #   [y-10, y+10].each do |yy|
    #     result = false unless on_map(xx,yy)
    #   end
    # end
    # result
    # on_map?(x,y) # && !occupied?(x, y, excluded)
    true
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
      Random.rand(@food_number-@food.size).times do
        @food << Brain::Food.new(self)
      end
    end
end