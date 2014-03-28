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
    
    
    # @check_ins = User.check_ins.first(5)
    
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
    
    #<% @check_ins.each do |l|%>
    #<p><%= l.place_id.name %></p>
    #<% end %>
    
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
    
          #caras number: 4025258220
          #johns number: 4023219124
          #kaits number: 4022167901
          
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