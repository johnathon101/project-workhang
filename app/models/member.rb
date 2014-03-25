class Member < ActiveRecord::Base
  attr_accessible :group_id, :moderator_id, :user_id
end
