require 'rails_helper'

describe ForcedMoves do
  subject(:forced) { ForcedMoves.new(board_state).moves }
  let(:game) do
    instance_double(Game).tap do |game|
      allow(game).to receive(:colors).and_return(Color.first(4))
      allow(game).to receive(:shape).and_return(Board::Rhombus.new(3))
      allow(game).to receive(:moves).and_return(previous_moves)
    end
  end
  let(:board_state) { BoardState.new(game) }
  let(:previous_moves) { [] }

  def move(x, y, z, color)
    Struct.new(:hex, :tile).new(Hex.new(x, y, z), Tile.new(Color[color]))
  end

  context 'on an empty board' do
    it { is_expected.to be_empty }
  end

  context 'with a red in the corner' do
    let(:previous_moves) do
      [ move(0, 0, 0, :red) ]
    end

    it { is_expected.to be_empty }
  end

  context 'forcing a yellow' do
    let(:previous_moves) do
      [
        move(1, -1, 0, :red),
        move(0, -1, 1, :green),
        move(0, -2, 2, :blue)
      ]
    end

    it { is_expected.to eq [[Hex.new(1, -2, 1), Tile.new(Color[:yellow])]] }
  end

  context 'forcing a black' do
    let(:previous_moves) do
      [
        move(1, -1, 0, :red),
        move(0, -1, 1, :green),
        move(0, -2, 2, :blue),
        move(2, -3, 1, :yellow)
      ]
    end

    it { is_expected.to match_array [[Hex.new(1, -2, 1), Blockage.new]] }
  end

  context 'forcing two blacks' do
    let(:previous_moves) do
      [
        move(0,  0, 0, :green),
        move(0, -2, 2, :red),
        move(1, -2, 1, :blue),
        move(2, -2, 0, :red)
      ]
    end

    it { is_expected.to match_array [
      [Hex.new(0, -1, 1), Blockage.new],
      [Hex.new(1, -1, 0), Blockage.new]
    ] }
  end
end
