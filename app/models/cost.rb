class Cost < ApplicationRecord
  has_many :extra_costs, dependent: :destroy, class_name: 'ExtraCost', foreign_key: 'cost_id'
  belongs_to :user
  accepts_nested_attributes_for :extra_costs
end
