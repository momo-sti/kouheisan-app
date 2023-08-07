class FavoriteLocation < ApplicationRecord
  belongs_to :user
  validate :limit_favorite_locations, on: :create


  private

  def limit_favorite_locations
    if user.favorite_locations.count >= 3
      errors.add(:user_id, "can't have more than 3 favorite locations")
    end
  end
end
