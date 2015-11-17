
module HumanMovement
  extend self

  def move(human, game)
    @board   = game.board
    @display = game.display
    @human   = human

    set_random_direction
    move_human_if_possible
  end

  def set_random_direction
    @random_direction = %w(left right).sample
  end

  def move_human_if_possible
    if new_direction && human_can_move?
      go_down_and_update_direction
    end

    unless new_direction || overlapping?
      @display.update { @human.send("move_#{@random_direction}") }
    end
  end

  def new_direction
    @board.find_wall(@human)
  end

  def human_can_move?
    !(@board.last_row?(@human) || @board.position_used?(@human.x+1, @human.y))
  end

  def go_down_and_update_direction
    @display.update { @human.move_down }
    @display.update { @human.send("move_#{new_direction}") }
  end

  def overlapping?
    @board.position_used?(@human.x, calculate_new_y_position)
  end

  def calculate_new_y_position
    @random_direction == "left" ? @human.y-1 : @human.y+1
  end
end
