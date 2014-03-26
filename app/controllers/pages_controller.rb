class PagesController < ApplicationController
  
  def home
    @user = User.new
  end
  
  def logout
    
  end
end