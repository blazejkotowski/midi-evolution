require 'gosu'

class World < Gosu::Window
  @@world = nil
  def self.instance
    @@world
  end

  def initialize(agents_number, width = 800, height = 800)
    super width, height

    @width = width
    @height = height
    self.caption = ""

    # Agents that survived
    @survivors = (1..2).map { Brain::Agent.new self }

    # Alive agents
    @agents = []

    generate_agents
  end

  def update
  end

  def draw
    @agents.each { |a| a.draw }
  end

  def random_x
    Random.rand(width)
  end

  def random_y
    Random.rand(height)
  end

  private
    def generate_agents
      # Summons new agents to life mutating the collection of survivors
      (AGENTS_NUMBER-@survivors.size).times do
        @survivors.rotate!
        @agents << @survivors.first.mutation
      end
    end
end