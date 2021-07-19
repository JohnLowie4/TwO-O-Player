# Player class and it's individual attribute
class Player

  attr_accessor :life

  def initialize
    @life = 3
  end

  def lose_life
    @life -= 1
  end

end