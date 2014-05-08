class PagesController < ApplicationController
  def home
    @user = User.new
    if current_user && current_user.groups != [] || nil
    groups = current_user.groups
    @checks = []
    groups.each do |group|
      check_in = group.check_ins
      @checks << check_in
    end
    @checks = @checks.flatten
    @check_ins = []
    @checks.each do |check|
      if check["time_out"] == nil
        @check_ins << check
      end
    end
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
    @users = User.where(:id => @users)
    @places = Place.where(:id => @places)
    @user_gravs=Array.new
    @users.each do |user|
      location=CheckIn.where(:user_id => user.id, :time_out => nil).each do |place|
      @user_gravs <<[Gravatar.new(user.email).image_url + "?s=75", place.place_id]
      end
    end
  else
    if current_user
    if current_user.check_ins.where(time_out:nil) == []
      @check_ins = []
    else
      @checks = current_user.check_ins
      @check_ins = @checks.where(time_out: nil)
      @check_ins = @check_ins.first
      @places = @check_ins.place_id
      @users = @check_ins.user_id
      @times = @check_ins.created_at
      @users = User.where(:id => @users)
      @places = Place.where(:id => @places)
      @user_gravs=Array.new
      @users.each do |user|
        location=CheckIn.where(:user_id => user.id, :time_out => nil).each do |place|
        @user_gravs <<[Gravatar.new(user.email).image_url + "?s=75", place.place_id]
        end
    end
    end
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
