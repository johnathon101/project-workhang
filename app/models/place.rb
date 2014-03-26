class Place < ActiveRecord::Base

  attr_accessible :city, :desc, :hours, :lat, :lng, :name, :occupied, :review_id, :street, :user_id, :zipcode

  has_many :users, :through => :check_ins
  has_many :check_ins
end
