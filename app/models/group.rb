class Group < ActiveRecord::Base
  attr_accessible :desc, :mod, :name, :place_id
  
  has_many :users, :through => :members
  has_many :check_ins, :through => :users
  has_many :members
end
