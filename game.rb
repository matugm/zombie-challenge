require_relative 'board'

board = Board.new(11)

def update_board(board)
  system "clear"

  yield

  board.print_board

  $stdout.flush
  sleep(0.1)
end

(0...10).step(2) do |x|
  10.times do |n|
    update_board(board) { board.move_piece_left(x, 10-n) }
  end

  update_board(board) { board.move_piece_down(x, 0) }

  10.times do |n|
    update_board(board) { board.move_piece_right(x+1, 0+n) }
  end

  update_board(board) { board.move_piece_down(x+1, 10) }
end

# Last line

10.times do |n|
  update_board(board) { board.move_piece_left(9, 10-n) }
end

# Idea: Have objects for every piece. Pieces keep track of their position on the board (x,y),
# and know how to move themselves (left, right, down, up).
#
# A 2d array is recreated every turn from the objects. The 2d array is exclusively used for display,
# and not for state.
