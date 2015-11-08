
class Piece
  attr_reader :type, :x, :y

  def initialize(type, x = 0, y = 0)
    @type  = type
    @x, @y = x, y
  end

  def move_left
    @y -= 1
  end

  def move_right
    @y += 1
  end

  def move_down
    @x += 1
  end
end
