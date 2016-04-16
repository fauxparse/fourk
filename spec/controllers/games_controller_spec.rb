require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { FactoryGirl.create(:game) }

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: game }
      expect(response).to have_http_status(:success)
    end
  end
end