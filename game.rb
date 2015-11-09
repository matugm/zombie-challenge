require_relative 'board'
require_relative 'piece'

BOARD_SIZE = 5

board = Board.new(BOARD_SIZE)

zombie = Piece.new(:zombie, 0, 2)

board.add_piece zombie
board.add_piece Piece.new(:human, 0, 1)
board.add_piece Piece.new(:human, 1, 1)
board.add_piece Piece.new(:human, 2, 0)

class Display
  def initialize(board)
    @board = board
  end

  def update
    system "clear"

    yield if block_given?

    @board.generate
    @board.print_board

    $stdout.flush
    sleep(0.5)
  end
end

display = Display.new(board)

# Initial display
display.update

# Movement
direction = "left"

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
