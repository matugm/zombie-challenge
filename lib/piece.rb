
class Piece
  attr_accessor :type, :direction
  attr_reader :x, :y

  def initialize(type, x = 0, y = 0, direction = "left")
    @type  = type
    @x, @y = x, y

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

  def to_s
    type_map = {
      zombie: "Z",
      human:  "H"
    }

    type_map[@type]
  end

  alias_method :display_type, :to_s
end
