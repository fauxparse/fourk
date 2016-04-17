class AddStateInformationToGames < ActiveRecord::Migration[5.0]
  def change
    change_table :games do |t|
      t.string :state
      t.integer :starting_player_position
    end
  end
end
