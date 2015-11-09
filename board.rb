
class Board
  attr_reader :pieces, :board

  def initialize(board_size)
    @board_size = board_size

    @pieces = []
  end

  def generate
    reset_board

    @pieces.each { |piece| @board[piece.x][piece.y] = piece.display_type }

    @board
  end

  def add_piece(piece)
    @pieces << piece
  end

  def find_wall_left?(piece)
    piece.y <= 0
  end

  def find_wall_right?(piece)
    piece.y >= @board_size - 1
  end

  def last_row?(piece)
    piece.x == @board_size - 1
  end

  def reset_board
    @board = Array.new(@board_size) { [] }
  end

  def print_board
    @board

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
