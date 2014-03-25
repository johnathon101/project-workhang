class Review < ActiveRecord::Base
  attr_accessible :content, :place_id, :title, :user_id
end
