class Cost < ApplicationRecord
  has_many :extra_costs, dependent: :destroy, class_name: 'ExtraCost', foreign_key: 'cost_id'
  belongs_to :user
  accepts_nested_attributes_for :extra_costs # ExtraCost オブジェクトも同時に保存

  def self.create_with_extras(params)
    # extras以外のparamsを初期化
    cost = new(params.except(:extras))
    ActiveRecord::Base.transaction do
      cost.save!
      params[:extras]&.each do |extra|
        cost.extra_costs.create!(
          category: extra['category'],
          amount: extra['amount']
        )
      end
    end
    cost
  end
end
