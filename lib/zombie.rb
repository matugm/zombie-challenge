
module ZombieMovement
  extend self

  def move(game)
    @board   = game.board
    @display = game.display
    @zombie  = game.zombie

    check_walls

    update { @zombie.send("move_#{@zombie.direction}") }
  end

  private

  def update
    yield
    @board.updated_position(@zombie.x, @zombie.y)
    @display.update
  end

  def check_walls
    new_direction = @board.find_wall(@zombie)
    return unless new_direction

    exit if @board.last_row?(@zombie)

    update { @zombie.update_direction_and_move_down(new_direction) }
  end
end
