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

# Zombie movement
loop do
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
