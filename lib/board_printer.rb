
class BoardPrinter
  def initialize(board, board_size)
    @board = board
    @board_size = board_size
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

  def update_board(updated_board)
    @board = updated_board
  end
end
