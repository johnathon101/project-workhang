class LoginsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # <-- That is what a "log in" is.
      redirect_to :root
    else
      raise "Login failed. Try logging in again."
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end