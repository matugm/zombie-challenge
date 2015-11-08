
class Board
  def initialize(board_size)
    @board = Array.new(board_size) { [] }

    map_setup

    @board_size = board_size
  end

  def map_setup
    @board[0][1]  = "H"
    @board[0][6]  = "H"
    @board[0][10] = "Z"

    @board[1][2]  = "H"

    @board[4][1]  = "H"
    @board[4][2]  = "H"

    @board[6][4]  = "H"
    @board[6][8]  = "H"

    @board[8][8]  = "H"
    @board[8][3]  = "H"
  end

  def move_piece_left(x, y)
    if @board[x][y-1] == "H"
      @board[x][y-1], @board[x][y] = @board[x][y], "Z"
    else
      @board[x][y-1], @board[x][y] = @board[x][y], nil
    end
  end

  def move_piece_right(x, y)
    if @board[x][y+1] == "H"
      @board[x][y+1], @board[x][y] = @board[x][y], "Z"
    else
      @board[x][y+1], @board[x][y] = @board[x][y], nil
    end
  end

  def move_piece_down(x, y)
    if @board[x+1][y] == "H"
      @board[x+1][y], @board[x][y] = @board[x][y], "Z"
    else
      @board[x+1][y], @board[x][y] = @board[x][y], nil
    end
  end

  def print_board
    print_header
    @board_size.times { |n| print_line(n) }
    print_header
  end

  def print_header
    puts "#" * (@board_size + 2)
  end

  def print_line(row)
    puts "#" + line_contents(row) + "#"
  end

  def line_contents(row)
    get_row(row).ljust(@board_size)
  end

  def get_row(row)
    @board[row].map { |i| i.nil? ? " " : i }.join
  end
end

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
