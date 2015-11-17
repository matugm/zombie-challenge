
class Piece
  attr_accessor :direction
  attr_reader :x, :y, :type

  def initialize(x = 0, y = 0, direction = "left")
    @x, @y     = x, y
    @direction = direction
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

class Human < Piece
  def display_type
    "H"
  end

  def type
    :human
  end
end

class Zombie < Piece
  def display_type
    "Z"
  end

  def type
    :zombie
  end
end
