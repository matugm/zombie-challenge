
module ZombieMovement
  extend self

  def move(zombie, game)
    @board   = game.board
    @display = game.display

    check_walls(zombie)

    @display.update { zombie.send("move_#{zombie.direction}") }
  end

  def check_walls(zombie)
    new_direction = @board.find_wall(zombie)
    return unless new_direction

    exit if @board.last_row?(zombie)

    zombie.direction = new_direction
    @display.update { zombie.move_down }
  end
end
