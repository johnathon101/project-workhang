class UsersController < ApplicationController
  
  def index
    @users = User.all
    
    @users.each do |user|
      avatar = Gravatar.new(user.email).image_url
      @avatar = avatar + "?s=75"
    end
    
  end

  def show
    @user = User.find(params[:id])
    avatar = Gravatar.new(@user.email).image_url
    @avatar = avatar + "?s=200"
    
    # x = @user.places
    # @fav_places = most_common_value(x)
    
    
    # TODO add below back in to show.html
    # 
    # <% if @fav_places.size == 0 %>
    #   <p><%= @user.fname %> has yet to check in</p>
    # <% else %>
    #   <% @fav_places.each do |places| %>
    #   <ul>
    #     <li><%= places.name %><li>
    #     </ul>
    #   <% end %>
    #   
    # <% end %>
    
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    
      @user = User.new(params[:user])
      
      if @user.save
        # session[:user_id] = @user.id
        redirect_to(edit_user_path(@user.id))
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