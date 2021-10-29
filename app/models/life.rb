class Life
  attr_accessor :game, :seeds

  def initialize(game = Game.new, seeds = [])
    @game = game
    @seeds = seeds

    seeds.each do |seed|
      world.matrix[seed[0]][seed[1]].alive = true
    end
  end
end
