
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

  def to_s
    type_map = {
      zombie: "Z",
      active_zombie: "Z",
      human:  "H"
    }

    type_map[@type]
  end

  alias_method :display_type, :to_s
end
