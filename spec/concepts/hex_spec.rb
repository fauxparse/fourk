require 'rails_helper'

describe Hex do
  describe '#initialize' do
    context 'with valid co-ordinates' do
      subject { Hex.new(1, 0, -1) }

      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'with invalid co-ordinates' do
      subject { Hex.new(1, 2, 3) }

      it 'raises an error' do
        expect { subject }
          .to raise_error(ArgumentError, "co-ordinates must sum to 0")
      end
    end
  end

  describe '#==' do
    subject { Hex.new(1, 0, -1) }
    it { is_expected.to eq Hex.new(1, 0, -1) }
    it { is_expected.not_to eq Hex.new(-1, 0, 1) }
  end

  describe '#+' do
    subject { Hex.new(2, -2, 0) + Hex.new(-1, 0, 1) }
    it { is_expected.to eq Hex.new(1, -2, 1) }
  end

  describe '#-' do
    subject { Hex.new(1, -2, 1) - Hex.new(2, -1, -1) }
    it { is_expected.to eq Hex.new(-1, -1, 2) }
  end

  describe '#-@' do
    subject { -Hex.new(1, -1, 0) }
    it { is_expected.to eq Hex.new(-1, 1, 0) }
  end

  describe '#to_a' do
    subject { Hex.new(1, 2, -3).to_a }
    it { is_expected.to eq [1, 2, -3] }
  end

  describe '#neighbours' do
    subject { Hex.new(1, -2, 1).neighbours }
    it {
      is_expected.to match_array [
        Hex.new(2, -3, 1),
        Hex.new(2, -2, 0),
        Hex.new(1, -1, 0),
        Hex.new(0, -1, 1),
        Hex.new(0, -2, 2),
        Hex.new(1, -3, 2)
      ]
    }
  end

  describe '.origin' do
    subject { Hex.origin }
    it { is_expected.to eq Hex.new(0, 0, 0) }
  end

  describe '.from_axial' do
    subject { Hex.from_axial(-2, 3) }
    it { is_expected.to eq Hex.new(-2, -1, 3) }
  end
end
