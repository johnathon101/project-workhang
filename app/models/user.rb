class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :phone_num, :twitter, :website, :projects, :mentor, :bio

  
  # before do
  #   def full_name(fname, lname)
  #     @full_name = "#{fname.titleize} #{lname.titleize}"
  #   end
  # end

  def normalize_name
    self.fname = self.fname.downcase.titleize
    self.lname = self.lname.downcase.titleize
  end
  
  def full_name
    "#{self.fname} #{self.lname}"
  end

end
