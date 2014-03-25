class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :phone_num, :twitter, :website, :projects, :mentor, :bio
  
  def full_name
    "#{self.fname.downcase.titleize} #{self.lname.downcase.titleize}"
  end

end
