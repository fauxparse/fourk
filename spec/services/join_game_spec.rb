require 'rails_helper'

describe JoinGame do
  subject(:service) { JoinGame.new(alice, game) }
  let(:alice) { FactoryGirl.create(:user) }
  let(:bob) { FactoryGirl.create(:user) }
  let(:claire) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game) }

  context 'when the game is empty' do
    it 'succeeds' do
      expect(service)
        .to receive(:publish)
        .with(:success)
        .and_call_original
      service.call
    end
  end

  context 'when the game has one other player' do
    before { Player.create(user: bob, game: game) }

    it 'succeeds' do
      expect(service)
        .to receive(:publish)
        .with(:success)
        .and_call_original
      service.call
    end

    it 'starts the game' do
      expect(StartGame)
        .to receive(:new).with(game)
        .and_call_original
      service.call
      expect(game).to be_playing
    end
  end

  context 'when Alice is already playing' do
    before { Player.create(user: alice, game: game) }

    it 'fails' do
      expect(service)
        .to receive(:publish)
        .with(:already_playing)
        .and_call_original
      service.call
    end
  end

  context 'when the game is already full' do
    before do
      Player.create(user: bob, game: game)
      Player.create(user: claire, game: game)
    end

    it 'fails' do
      expect(service)
        .to receive(:publish)
        .with(:full)
        .and_call_original
      service.call
    end
  end

  context 'when the user is nil' do
    let(:alice) { nil }

    it 'fails' do
      expect(service)
        .to receive(:publish)
        .with(:failure, an_instance_of(Player))
        .and_call_original
      service.call
    end
  end
end
