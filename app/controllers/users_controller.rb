class UsersController < ApplicationController
  
  def index
    @users = User.all
    @users.each do |user|
      @avatar = Gravatar.new(user.email).image_url + "?s=75"
    end
  end

  def show
    @user = User.find(params[:id])
    @avatar = Gravatar.new(@user.email).image_url + "?s=155"
    
    checkin = @user.check_ins.where(time_out: nil)
    if checkin != []
      place_id = checkin.first.place_id
      @place = Place.find(place_id)
    end
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    @avatar = Gravatar.new(@user.email).image_url + "?s=75"
  end
  
  def text
    @user = User.find(params[:id])
  
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
          @client.account.messages.create(
            :from => ENV["TWILIO_NUMBER"],
            :to => ("+1" + @user.phone_num.to_s),
            :body => "Text from #{current_user.fname.capitalize} #{current_user.lname.capitalize}: #{params[:text]}"
          )      
          
    redirect_to(user_path(@user.id))
  end

  def create
    @user = User.new(params[:user])    
    
    if @user.save
      session[:user_id] = @user.id  
      redirect_to(edit_user_path(@user.id))
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
 
    if current_user.groups == []
      redirect_to :groups
    else
      redirect_to(user_path(@user.id))
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to(:root)
  end
  
end