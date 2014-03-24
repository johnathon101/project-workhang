class Group < ActiveRecord::Base
  attr_accessible :desc, :mod, :name
  
  has_many :users
end
