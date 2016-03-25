
class WallFinder
  def initialize(board)
    @board = board
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
    piece.y >= @board.size - 1
  end

  def last_row?(piece)
    piece.x == @board.size - 1
  end
end
