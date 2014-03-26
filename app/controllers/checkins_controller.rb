class LoginsController < ApplicationController

  def checkin
    @place = Place.find(params[:id])
  
    CheckIn.new({
      :place_id => @place.id
      :user_id => current_user.id
    })
  
    if CheckIn.save
      redirect_to(place_path(@place.id))
    else
      render "new"
    end
  end

  def checkout
    CheckIn.update_attributes({
      :time_out => Time.now
    })
  
    redirect_to(user_path(current_user.id))
  end 

end