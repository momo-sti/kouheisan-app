class FavoriteLocation < ApplicationRecord
  belongs_to :user
  validate :limit_favorite_locations, on: :create


  private

  def limit_favorite_locations
    if user.favorite_locations.count >= 3
      errors.add(:base, "3つまでしか登録できません")
    end
  end
end
