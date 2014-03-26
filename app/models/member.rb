class Member < ActiveRecord::Base
  attr_accessible :group_id, :moderator_id, :user_id
  
  belongs_to :user, :inverse_of => :member
  belongs_to :group, :inverse_of => :member
end
