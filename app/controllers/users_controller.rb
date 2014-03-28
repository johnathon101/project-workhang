class UsersController < ApplicationController
  
  def index
    @users = User.all
    @users.each do |user|
      @avatar = Gravatar.new(user.email).image_url + "?s=75"
    end
  end

  def show
    @user = User.find(params[:id])
    @avatar = Gravatar.new(@user.email).image_url + "?s=200"
    
    @recent_places = Place.where(:id => CheckIn.where(:user_id => @user.id)).order("created_at DESC").first(3)
    
    @fav_places = []
    user_checkins = CheckIn.where(:user_id => @user.id)
    user_checkins.each do |place|
      @fav_places << Place.where(:id => place.id)
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
    @current_user = current_user.fname
  
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
          @client.account.messages.create(
            :from => ENV["TWILIO_NUMBER"],
            :to => ("+1" + @user.phone_num.to_s),
            # :to => +14023219124, #john
            :body => "text from #{@user.fname} #{@user.lname}: #{params[:text]}"
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
    redirect_to(:groups)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to(:root)
  end
  
end