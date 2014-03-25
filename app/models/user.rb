class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :fname, :lname, :password, :password_confirmation, :phone_num
  
  def most_common_value(a)
    a.group_by do |e|
      e
    end.values.max_by(&:size).first
  end
  
  has_many :groups, :through => :members
  has_many :members
  
end
