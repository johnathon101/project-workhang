class LoginsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    @admins=['ytmoik@gmail.com', 'mikejtodd@gmail.com', 'ja.lueth@gmail.com']
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      redirect_to :root
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end