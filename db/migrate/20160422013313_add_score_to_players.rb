class AddScoreToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :score, :integer, default: 0
  end
end
