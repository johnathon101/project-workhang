class Place < ActiveRecord::Base
  attr_accessible :city, :desc, :hours, :lat, :lng, :name, :occupied, :review_id, :street, :user_id, :zipcode
end
