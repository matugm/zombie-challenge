require_relative 'board_printer'

class Board
  attr_reader :pieces, :board

  def initialize(board_size)
    @board_size = board_size
    @pieces     = []

    @board_printer = BoardPrinter.new(self)

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

  def [](x)
    @board[x]
  end

  def size
    @board_size
  end

  def print_board
    @board_printer.print_board
  end

  def get_row(n)
    @board_printer.get_row(n)
  end
end
