class CreateCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :costs do |t|
      t.references :user, foreign_key: true, null: false
      t.float :total_amount, null: false
      t.string :duration
      t.float :gasoline_cost, null: false
      t.float :distance, null: false
      t.float :fuel_efficiency, null: false
      t.float :place_per_liter, null: false
      t.float :highway_cost, null: false
      t.string :start_place
      t.string :arrival_place

      t.timestamps
    end
  end
end
