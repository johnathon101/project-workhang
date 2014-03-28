class TextsController < ApplicationController
  
  def index
  end
  
  def new
  end
  
  def create
    text = Text.create(params[:text])
    @message = text.message
    user = User.find_by_email(params[:email])
    redirect_to(@user.id)
  end
  
end