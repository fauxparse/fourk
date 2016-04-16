class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :board_shape
      t.integer :board_size
      t.timestamps
    end
  end
end
