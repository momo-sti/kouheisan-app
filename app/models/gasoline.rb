class Gasoline
  include ActiveModel::Model

  attr_accessor :total_distance, :fuel_efficiency, :price_per_liter

  validates :total_distance, :fuel_efficiency, :price_per_liter, presence: true

  def calculate
    return nil unless valid?

    result = (total_distance.to_f / fuel_efficiency) * price_per_liter.to_f
    result.round(1)
  end
end
