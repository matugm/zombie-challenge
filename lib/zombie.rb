
class ZombieMovement
  attr_reader :zombie

  def initialize(zombie, game)
    @board   = game.board
    @display = game.display
    @zombie  = zombie
    @direction = "left"
  end

  def move
    if board.find_wall_left?(zombie)
      return if board.last_row?(zombie)

      @direction = "right"
      display.update { zombie.move_down }
    end

    if board.find_wall_right?(zombie)
      return if board.last_row?(zombie)

      @direction = "left"
      display.update { zombie.move_down }
    end

    display.update { zombie.send("move_#{@direction}") }
  end
end
