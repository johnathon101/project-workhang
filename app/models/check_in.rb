class CheckIn < ActiveRecord::Base
  attr_accessible :place_id, :time_out, :user_id

  belongs_to :user, :inverse_of => :check_in
  belongs_to :place, :inverse_of => :check_in
end