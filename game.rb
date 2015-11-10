require_relative 'lib/board'
require_relative 'lib/piece'
require_relative 'lib/loader'
require_relative 'lib/display'

BOARD_SIZE = 8

# Trap Ctrl-C to avoid exception
trap("SIGINT") { exit(0) }

board  = Board.new(BOARD_SIZE)
zombie = Piece.new(:zombie, 0, 5)

board.add_piece(zombie)

# Setup initial board state
MapLoader.load("basic_map", board)

# Setup display
display = Display.new(board, zombie)

# Initial display
display.update

# Initial direction
direction = "left"

# Movement
loop do
  board.pieces.select { |p| p.type == :human }.each do |human|
    directions       = %w(left right)
    random_direction = directions.sample

    if board.find_wall_left?(human)
      next if board.last_row?(human)
      next if board.position_used?(human.x+1, human.y)

      random_direction = "right"
      display.update { human.move_down }
    end

    if board.find_wall_right?(human)
      next if board.last_row?(human)
      next if board.position_used?(human.x+1, human.y)

      random_direction = "left"
      display.update { human.move_down }
    end

    # We need this to check if the new position
    # is already filled.
    #
    # This allows us to avoid overlapping.
    case random_direction
    when "left"
      new_x = human.x
      new_y = human.y-1
    when "right"
      new_x = human.x
      new_y = human.y+1
    end

    next if board.position_used?(new_x, new_y)

    display.update { human.send("move_#{random_direction}") }
  end

  ## Zombie ##

  if board.find_wall_left?(zombie)
    break if board.last_row?(zombie)

    direction = "right"
    display.update { zombie.move_down }
  end

  if board.find_wall_right?(zombie)
    break if board.last_row?(zombie)

    direction = "left"
    display.update { zombie.move_down }
  end

  display.update { zombie.send("move_#{direction}") }
end
