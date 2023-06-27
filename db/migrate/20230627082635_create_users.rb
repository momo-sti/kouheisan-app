class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar
      t.string :line_id, null: false, index: { unique: true }
      t.integer :role

      t.timestamps
    end
  end
end
