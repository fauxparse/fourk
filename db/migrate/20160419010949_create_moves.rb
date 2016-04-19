class CreateMoves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.belongs_to :turn
      t.integer :x
      t.integer :y
      t.integer :z
      t.integer :position
      t.string :color

      t.timestamps
    end

    change_table :turns do |t|
      t.integer :moves_count, default: 0
    end
  end
end
