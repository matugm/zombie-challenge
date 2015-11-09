require_relative 'board'
require_relative 'piece'

BOARD_SIZE = 5

board = Board.new(BOARD_SIZE)

zombie = Piece.new(:active_zombie, 0, 2)

board.add_piece Piece.new(:human, 0, 1)
board.add_piece zombie
board.add_piece Piece.new(:human, 1, 1)
board.add_piece Piece.new(:human, 2, 0)

def update_board(board)
  system "clear"

  yield if block_given?

  board.generate
  board.print_board

  $stdout.flush
  sleep(0.5)
end

# Initial display
update_board(board)

# Movement
direction = "left"

loop do
  if board.find_wall_left?(zombie)
    break if board.last_row?(zombie)

    update_board(board) { zombie.move_down }
    direction = "right"
  end

  if board.find_wall_right?(zombie)
    break if board.last_row?(zombie)

    update_board(board) { zombie.move_down }
    direction = "left"
  end

  update_board(board) { zombie.send("move_#{direction}") }
end
