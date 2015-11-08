require_relative 'piece'

describe Piece do
  let(:piece) { Piece.new(:zombie) }

  it 'can move one position to the left' do
    initial_position = piece.y

    piece.move_left
    expect(piece.y).to eq initial_position - 1
  end
end
