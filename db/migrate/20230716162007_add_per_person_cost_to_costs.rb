class AddPerPersonCostToCosts < ActiveRecord::Migration[7.0]
  def change
    add_column :costs, :per_person_cost, :float
  end
end
