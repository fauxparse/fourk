require 'rails_helper'

describe Board::Rhombus do
  subject(:shape) { Board::Rhombus.new(size) }
  let(:size) { 2 }

  describe '#hexes' do
    subject { shape.hexes }
    it {
      is_expected.to match_array [
        Hex.new(0,  0, 0),
        Hex.new(1, -1, 0),
        Hex.new(0, -1, 1),
        Hex.new(1, -2, 1)
      ]
    }
  end
end
