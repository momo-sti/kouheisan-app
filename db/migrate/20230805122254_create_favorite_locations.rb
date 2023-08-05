class CreateFavoriteLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_locations do |t|
      t.integer :user_id, null: false
      t.integer :latitude, null: false
      t.integer :longitude, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
