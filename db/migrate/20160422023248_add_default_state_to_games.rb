class AddDefaultStateToGames < ActiveRecord::Migration[5.0]
  def up
    change_column :games, :state, :string, :default => "waiting_for_players"
    Game.where(state: nil).update_all(state: "pending")
  end

  def down
  end
end
