require 'piece'

describe Piece do
  let(:piece) { Human.new() }

  it 'can move one position to the left' do
    initial_position = piece.y

    piece.move_left
    expect(piece.y).to eq initial_position - 1
  end

  it 'returns an appropiate symbol' do
    expect(piece.display_type).to eq "H"
  end
end
