class CreateCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :costs do |t|
      t.references :user, foreign_key: true, null: false
      t.float :total_amount, null: false
      t.string :duration
      t.float :gasoline_cost
      t.float :distance
      t.float :fuel_efficiency
      t.float :gasoline_price
      t.float :highway_cost
      t.string :start_place
      t.string :arrival_place

      t.timestamps
    end
  end
end
