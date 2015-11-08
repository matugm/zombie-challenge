require_relative 'board'
require_relative 'piece'

BOARD_SIZE = 4

board = Board.new(BOARD_SIZE)

board.add_piece Piece.new(:human, 0, 1)
board.add_piece Piece.new(:zombie, 0, 2)
board.add_piece Piece.new(:human, 1, 1)
board.add_piece Piece.new(:human, 2, 0)

def update_board(board)
  system "clear"

  yield if block_given?

  board.generate
  board.print_board

  $stdout.flush
  sleep(1)
end

# Initial display
update_board(board)

(0...BOARD_SIZE-2).step(2) do |x|
  (BOARD_SIZE-1).times do |n|
    update_board(board) { board.pieces.select { |p| p.type == :zombie }.each { |p| p.move_left } }
  end

  update_board(board) { board.pieces.select { |p| p.type == :zombie }.each { |p| p.move_down } }

  (BOARD_SIZE-1).times do |n|
      update_board(board) { board.pieces.select { |p| p.type == :zombie }.each { |p| p.move_right } }
  end

  # update_board(board) { board.move_piece_down(x+1, 10) }
end

# Last line

# 10.times do |n|
#   update_board(board) { board.move_piece_left(9, 10-n) }
# end

# Idea: Have objects for every piece. Pieces keep track of their position on the board (x,y),
# and know how to move themselves (left, right, down, up).
#
# A 2d array is recreated every turn from the objects. The 2d array is exclusively used for display,
# and not for state.
