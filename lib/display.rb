
class Display
  def initialize(board, zombie)
    @board  = board
    @zombie = zombie
  end

  def update
    system "clear"

    yield if block_given?

    @board.updated_position(@zombie.x, @zombie.y)
    @board.generate
    @board.print_board

    $stdout.flush
    sleep(0.1)
  end
end
