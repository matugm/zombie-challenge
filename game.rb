require_relative 'lib/board'
require_relative 'lib/piece'
require_relative 'lib/loader'
require_relative 'lib/display'
require_relative 'lib/human'

BOARD_SIZE = 8

# Trap Ctrl-C to avoid exception
trap("SIGINT") { exit(0) }

class Game
  attr_reader :board, :zombie, :display

  def initialize
    @board  = Board.new(BOARD_SIZE)
    @zombie = Piece.new(:zombie, 0, 5)

    board.add_piece(zombie)

    @zombie_direction = "left"

    # Setup initial board state
    MapLoader.load("basic_map", board)

    # Setup display
    @display = Display.new(board, zombie)

    # Initial display
    display.update
  end

  def main_loop
    loop do
      human_movement
      zombie_movement
    end
  end

  def humans
    board.pieces.select { |p| p.type == :human }
  end

  def human_movement
    humans.each { |human| HumanMovement.move(human, self) }
  end

  def zombie_movement
    if board.find_wall_left?(zombie)
      return if board.last_row?(zombie)

      @zombie_direction = "right"
      display.update { zombie.move_down }
    end

    if board.find_wall_right?(zombie)
      return if board.last_row?(zombie)

      @zombie_direction = "left"
      display.update { zombie.move_down }
    end

    display.update { zombie.send("move_#{@zombie_direction}") }
  end
end

game = Game.new
game.main_loop
