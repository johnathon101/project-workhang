class Place < ActiveRecord::Base
  attr_accessible :city, :desc, :hours, :lat, :lng, :name, :occupied, :review_id, :street, :zipcode

  has_and_belongs_to_many :users
end
