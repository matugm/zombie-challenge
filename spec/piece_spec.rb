require 'piece'

describe Piece do
  let(:piece) { Piece.new(:zombie) }

  it 'can move one position to the left' do
    initial_position = piece.y

    piece.move_left
    expect(piece.y).to eq initial_position - 1
  end

  it 'implements to_s to display the piece symbol' do
    expect(piece.to_s).to eq "Z"
  end
end