class CreateTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|
      t.belongs_to :game
      t.belongs_to :player
      t.integer :position
      t.timestamps
    end

    change_table :games do |t|
      t.integer :turns_count, default: 0
    end
  end
end
