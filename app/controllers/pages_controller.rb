class PagesController < ApplicationController
  
  def home
    @user = User.new
    if current_user
    groups = current_user.groups
    check_ins = []
    groups.each do |group|
      check_in = group.check_ins
      check_ins << check_in
    end
    check_ins = check_ins.first
    check_ins = check_ins.where(time_out: nil)
    places = []
    check_ins.each do |check_in|
      place = check_in.place_id
      places << place
    end
    gon.places=Place.where(id: places)
    end
  end
  
  def logout
    
  end
  
  def about
    
  end
end