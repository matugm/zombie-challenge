require_relative 'board_printer'

class Board
  attr_reader :pieces, :board

  def initialize(board_size)
    @board_size = board_size
    @pieces     = []

    @board_printer = BoardPrinter.new(@board, @board_size)

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
    @board_printer.update_board(@board)
    @board_printer.print_board
  end
end
