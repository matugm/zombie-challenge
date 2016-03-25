
class BoardPrinter
  def initialize(board)
    @board = board
  end

  def print_board
    print_header
    @board.size.times { |n| print_line(n) }
    print_header
  end

  def print_header
    puts "#" * (@board.size + 4)
  end

  def print_line(row)
    puts "# " + line_contents(row) + " #"
  end

  def line_contents(row)
    get_row(row).ljust(@board.size)
  end

  def get_row(row)
    @board[row].map { |i| i.nil? ? " " : i.display_type }.join
  end
end
