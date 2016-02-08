module Brain
  class Food < Base
    def initialize(world)
      super world
      print "agent #{@@world}"
      @body = Body::Food.new
    end
  end
end