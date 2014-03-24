class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @places = User.places.check_in.order()
    avatar = Gravatar.new("ytmoik@gmail.com").image_url
    @avatar = avatar + "?s=200"
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:post])
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to(user_path(@user.id))
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    
    redirect_to(user_path(@user.id))
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to(:root)
  end
end