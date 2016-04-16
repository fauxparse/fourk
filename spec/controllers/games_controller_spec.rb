require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { FactoryGirl.create(:game) }
  let(:alice) { FactoryGirl.create(:user) }

  before do
    allow_any_instance_of(described_class)
      .to receive(:current_user)
      .and_return(alice)
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: game }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:request) { post :create }
    let(:game) { Game.oldest_first.last }

    it 'creates a new game' do
      expect { request }.to change { Game.count }.by(1)
    end

    it 'creates a new player' do
      expect { request }.to change { Player.count }.by(1)
    end

    it 'adds the current user to the game' do
      request
      expect(game.users).to include(alice)
    end

    it 'redirects to the new game' do
      request
      expect(response).to redirect_to game
    end
  end

  describe 'POST #join' do
    let(:request) { post :join, params: { id: game } }
    let(:game) { FactoryGirl.create(:game_with_player) }

    context 'for an open game' do
      it 'creates a player' do
        expect { request }.to change { game.players.count }.by(1)
      end

      it 'redirects to the game' do
        request
        expect(response).to redirect_to game
      end

      it 'fills up the game' do
        expect { request }
          .to change { game.full? }
          .from(false)
          .to(true)
      end
    end

    context 'for a full game' do
      before do
        FactoryGirl.create(:player, game: game)
      end

      it 'does not create a player' do
        expect { request }.not_to change { game.players.count }
      end

      it 'redirects to the games list' do
        request
        expect(response).to redirect_to games_path
      end
    end

    context 'for a game Alice is already playing' do
      let(:alice) { game.users.first }

      it 'does not create a player' do
        expect { request }.not_to change { game.players.count }
      end

      it 'redirects to the games list' do
        request
        expect(response).to redirect_to games_path
      end
    end
  end
end
