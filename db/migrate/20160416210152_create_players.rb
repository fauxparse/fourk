class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.integer    :position
      t.timestamps
    end

    change_table :games do |t|
      t.integer :players_count, default: 0
    end
  end
end
