class PagesController < ApplicationController
  def home
    @user = User.new
    if current_user && current_user.groups != []
    groups = current_user.groups
    @check_ins = []
    groups.each do |group|
      check_in = group.check_ins
      @check_ins << check_in
    end
    @check_ins = @check_ins.first
    @check_ins = @check_ins.where(time_out: nil)
    @places = []
    @user_ids = []
    @times = []
    @check_ins.each do |check_in|
      place = check_in.place_id
      user = check_in.user_id
      time = check_in.created_at
      @places << place
      @user_ids << user
      @times << time
    end
    end
    @users = User.where(:id => @user_ids)
    @places = Place.where(:id => @places)
    gon.places = @places
  end
  
  def logout
    
  end
  
  def about
    
  end
end