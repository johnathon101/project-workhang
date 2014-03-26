class PagesController < ApplicationController
  
  def home
    @user = User.new
    @groups = []
    if current_user
    current_user.members.each do |member|
      group = member.group_id
      @groups << group
    end
    end
  end
  
  def logout
    
  end
  
  def about
    
  end
end