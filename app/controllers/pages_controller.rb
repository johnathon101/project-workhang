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
    @new_check = []
    @check_ins.each do |a|
      if a["time_out"]==nil
        @new_check << a
      end
    end
    @check_ins = @new_check
    @places = []
    @users = []
    @times = []
    @check_ins.each do |check_in|
      place = check_in.place_id
      user = check_in.user_id
      time = check_in.created_at
      @places << place
      @users << user
      @times << time
    end
    end

    @users = User.where(:id => @users)
    @places = Place.where(:id => @places)
    @user_gravs=Array.new
    @users.each do |user|
      location=CheckIn.where(:user_id => user.id, :time_out => nil).each do |place|
      @user_gravs <<[Gravatar.new(user.email).image_url + "?s=75", place.place_id]
      end
    end
    gon.places = @places
    gon.group_people=@user_gravs
  end
  
  def logout
    
  end
  
  def about
    
  end
end