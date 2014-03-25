class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :phone_num, :group_id, :place_id, :checked_in
  
  has_and_belongs_to_many :groups 
  has_and_belongs_to_many :places
end
