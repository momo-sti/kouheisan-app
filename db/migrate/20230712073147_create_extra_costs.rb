class CreateExtraCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :extra_costs do |t|
      t.references :cost, foreign_key: true, null: false
      t.string :category, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
