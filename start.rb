require './world'

dirs = %w(body brain)
dirs.each do |dir|
  Dir[File.dirname(__FILE__) + "/#{dir}/*.rb"].each { |filename| require(filename) }
end


AGENTS_NUMBER = 5
FOOD_NUMBER = 10

$world = World.new(AGENTS_NUMBER, FOOD_NUMBER, 1200, 1000)
$world.show