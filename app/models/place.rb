class Place < ActiveRecord::Base

  attr_accessible :city, :desc, :hours, :lat, :lng, :name, :occupied, :review_id, :street, :user_id, :zipcode, :group_id

  has_many :users, :through => :check_ins
  has_many :check_ins
  
  searchable do
    text :name
    latlon :location do 
      Sunspot::Util::Coordinates.new(lat, lng)
    end
  end
end
