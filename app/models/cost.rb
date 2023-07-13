class Cost < ApplicationRecord
  has_many :extra_costs
  belongs_to :user
end
