json.extract! favorite_location, :id, :user_id, :latitude, :longitude, :name, :created_at, :updated_at
json.url favorite_location_url(favorite_location, format: :json)
