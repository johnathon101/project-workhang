class CheckIn < ActiveRecord::Base
  attr_accessible :place_id, :time_out, :user_id
end
