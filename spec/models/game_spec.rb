require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { FactoryGirl.create(:game) }

  it { is_expected.to validate_presence_of :board_shape }
  it { is_expected.to validate_presence_of :board_size }
  it { is_expected.to validate_numericality_of(:board_size)
         .only_integer.is_greater_than(0) }
end
