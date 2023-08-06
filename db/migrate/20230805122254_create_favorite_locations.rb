class CreateFavoriteLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_locations do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.string :address, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
