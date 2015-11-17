
module HumanMovement
  extend self

  def move(human, game)
    @board   = game.board
    @display = game.display
    @human   = human

    set_random_direction

    new_direction = @board.find_wall(@human)

    go_down_and_update_direction(new_direction) if new_direction && human_can_move?

    return if new_direction
    return if overlapping?

    @display.update { human.send("move_#{@random_direction}") }
  end

  def set_random_direction
    @random_direction = %w(left right).sample
  end

  def human_can_move?
    !(@board.last_row?(@human) || @board.position_used?(@human.x+1, @human.y))
  end

  def go_down_and_update_direction(direction)
    @display.update { @human.move_down }
    @display.update { @human.send("move_#{direction}") }
  end

  def overlapping?
    @board.position_used?(@human.x, calculate_new_y_position)
  end

  def calculate_new_y_position
    @random_direction == "left" ? @human.y-1 : @human.y+1
  end
end
