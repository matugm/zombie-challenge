
class Board
  attr_reader :pieces, :board

  def initialize(board_size)
    @board_size = board_size
    @pieces     = []

    reset_board
  end

  def generate
    reset_board

    @pieces.each { |piece| @board[piece.x][piece.y] = piece }
  end

  def add_piece(piece)
    @pieces << piece
  end

  def reset_board
    @board = Array.new(@board_size) { [] }
  end

  def updated_position(x, y)
    piece_index          = find_piece_index(x, y)
    @pieces[piece_index] = Zombie.new(x, y) if piece_index
  end

  def find_piece_index(x, y)
    @pieces.index { |p| p.type == :human && p.x == x && p.y == y }
  end

  def position_used?(x, y)
    @board[x][y].kind_of? Piece
  end

  def find_wall(piece)
    return "right" if find_wall_left?(piece)
    return "left"  if find_wall_right?(piece)
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

  def print_board
    print_header
    @board_size.times { |n| print_line(n) }
    print_header
  end

  def print_header
    puts "#" * (@board_size + 4)
  end

  def print_line(row)
    puts "# " + line_contents(row) + " #"
  end

  def line_contents(row)
    get_row(row).ljust(@board_size)
  end

  def get_row(row)
    @board[row].map { |i| i.nil? ? " " : i.display_type }.join
  end
end
