class Cost < ApplicationRecord
  has_many :extra_costs, class_name: 'ExtraCost', foreign_key: 'cost_id'
  belongs_to :user
end
