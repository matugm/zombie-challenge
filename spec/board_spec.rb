require 'piece'
require 'board'

describe Board do
  let(:board) { Board.new(3) }
  let(:piece) { Piece.new(:human, 0, 1) }

  it 'can generate an empty board' do
    result = [[],[],[]]

    board.generate

    expect(board.board).to eq result
  end

  it 'can generate a board with one piece' do
    result = [[nil, piece],[],[]]

    board.add_piece(piece)
    board.generate

    expect(board.board).to eq result
  end

  it 'can turn a row into a printable string' do
    board.add_piece Piece.new(:human, 0, 1)
    board.add_piece Piece.new(:zombie, 0, 2)

    board.generate
    expect(board.get_row(0)).to eq " HZ"
  end
end
