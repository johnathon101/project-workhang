class Group < ActiveRecord::Base
  attr_accessible :desc, :mod, :name
  
  has_and_belongs_to_many :users
end
