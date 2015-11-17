
class Display
  def initialize(board, zombie)
    @board  = board
  end

  def update
    system "clear"

    yield if block_given?

    @board.generate
    @board.print_board

    $stdout.flush
    sleep(0.1)
  end
end
