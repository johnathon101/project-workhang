class CheckinsController < ApplicationController

  def create
    @place = Place.find(params[:id])
  
    CheckIn.create({
      :place_id => @place.id, 
      :user_id => current_user.id,
      :time_in => Time.zone.now
    })
    
    redirect_to(place_path(@place.id))
  end

  def checkout
        
    # @check_in = current_user.check_ins.where(time_out: nil)
    #     
    # @check_in.update_attributes({
    #   :time_out => Time.now
    # })
    #   
    # redirect_to(:root)
            
    current_user.check_ins.where(time_out: nil).first.update_attributes({
      :time_out => Time.zone.now
    })
  
    redirect_to :back
    
  end 

end