require_relative 'piece'
require_relative 'board'

describe Board do
  let(:board) { Board.new(3) }
  let(:piece) { Piece.new(:human, 0, 1) }

  it 'can generate an empty board' do
    result = [[],[],[]]

    expect(board.generate).to eq result
  end

  it 'can generate a board with one piece' do
    result = [[nil, "H"],[],[]]

    board.add_piece(piece)

    expect(board.generate).to eq result

    board.print_board
  end
end
