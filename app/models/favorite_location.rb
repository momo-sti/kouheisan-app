class FavoriteLocation < ApplicationRecord
  belongs_to :user
  validate :limit_favorite_locations
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  private

  def limit_favorite_locations
    if user.favorite_locations.count >= 3
      errors.add(:user_id, "can't have more than 3 favorite locations")
    end
  end
end
