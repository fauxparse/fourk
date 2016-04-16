require 'rails_helper'

describe OpenGamesWithoutUser do
  let(:game)   { FactoryGirl.create(:game) }
  let(:alice)  { FactoryGirl.create(:user) }
  let(:bob)    { FactoryGirl.create(:user) }
  let(:claire) { FactoryGirl.create(:user) }

  subject { OpenGamesWithoutUser.new(alice).games }

  context 'when the game has no players' do
    it { is_expected.not_to include(game) }
  end

  context 'when Alice is already playing' do
    before { Player.create(user: alice, game: game) }
    it { is_expected.not_to include(game) }
  end

  context 'when the game has one player' do
    before { Player.create(user: bob, game: game) }
    it { is_expected.to include(game) }
  end

  context 'when the game has two players' do
    before do
      Player.create(user: bob, game: game)
      Player.create(user: claire, game: game)
    end
    it { is_expected.not_to include(game) }
  end
end
