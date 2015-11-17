require_relative 'lib/board'
require_relative 'lib/piece'
require_relative 'lib/loader'
require_relative 'lib/display'
require_relative 'lib/human'
require_relative 'lib/zombie'

BOARD_SIZE = 8

# Trap Ctrl-C to avoid exception
trap("SIGINT") { exit(0) }

class Game
  attr_reader :board, :zombie, :display

  def initialize
    @board  = Board.new(BOARD_SIZE)
    @zombie = Piece.new(:zombie, 0, 5)

    board.add_piece(zombie)

    # Setup initial board state
    MapLoader.load("basic_map", board)

    @display = Display.new(board, zombie)
    @display.update
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
    ZombieMovement.move(zombie, self)
  end
end

game = Game.new
game.main_loop
