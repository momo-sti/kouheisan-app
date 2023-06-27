class Highway
  include ActiveModel::Model

  attr_accessor :start_place, :arrive_place, :highway_cost

  validates :start_place, :arrive_place, :highway_cost, presence: true
end