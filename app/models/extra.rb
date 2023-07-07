class Extra
  include ActiveModel::Model
  attr_accessor :category, :amount, :id

  validates :category, presence: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def persisted?
    id.present?
  end
end
