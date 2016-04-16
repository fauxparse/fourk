require 'rails_helper'

describe Board do
  subject(:board) { Board.new(shape) }
  let(:shape) { Board::Rhombus.new(2) }

  describe '#hexes' do
    subject { board.hexes }
    it { is_expected.to match_array(shape.hexes) }
  end

  describe '#center' do
    subject { board.center }
    it { is_expected.to eq Hex.new(0.5, -1, 0.5) }
  end

  describe '#empty?' do
    it { is_expected.to be_empty }

    context 'with some content' do
      before { board[Hex.origin] = 1 }
      it { is_expected.not_to be_empty }
    end
  end

  describe '#[]' do
    subject { board[hex] }

    context 'with valid co-ordinates' do
      let(:hex) { Hex.origin }
      it { is_expected.to be_blank }

      context 'when the cell is full' do
        before { board[hex] = 1 }
        it { is_expected.to eq 1 }
      end
    end

    context 'with invalid co-ordinates' do
      let(:hex) { Hex.new(-1, 2, -1) }

      it 'checks its boundaries' do
        expect { subject }
          .to raise_error(ArgumentError, "co-ordinates out of bounds")
      end
    end
  end
end
