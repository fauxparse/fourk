require 'rails_helper'

describe StartGame do
  subject(:service) { StartGame.new(game) }
  let(:alice) { FactoryGirl.create(:player, game: game) }
  let(:bob) { FactoryGirl.create(:player, game: game) }
  let(:game) { FactoryGirl.create(:game) }

  context 'with two players' do
    before { alice && bob }

    it 'starts the game' do
      expect { service.call }
        .to change { game.playing? }
        .from(false).to(true)
    end

    it 'creates a turn' do
      expect { service.call }
        .to change { game.turns.count }
        .from(0).to(1)
    end

    it 'starts the turn with the first player' do
      service.call
      expect(game.turns.first.player.position)
        .to eq game.starting_player_position
    end
  end
end
