class CheckIn < ActiveRecord::Base
  attr_accessible :place_id, :time_out, :time_in, :user_id, :group_id

  belongs_to :user, :inverse_of => :check_in
  belongs_to :place, :inverse_of => :check_in
end
