class User < ApplicationRecord
  validates :line_user_id, presence: true, uniqueness: true
end
