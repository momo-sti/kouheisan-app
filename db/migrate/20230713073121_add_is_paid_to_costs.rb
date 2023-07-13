class AddIsPaidToCosts < ActiveRecord::Migration[7.0]
  def change
    add_column :costs, :is_paid, :boolean, default: false
  end
end
