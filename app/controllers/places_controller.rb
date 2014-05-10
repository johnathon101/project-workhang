class PlacesController < ApplicationController
  #Create methods to respond to js calls
  respond_to :json, :js
  # rescue_from 'OpenURI::HTTPError' do
  #       @message = " I am sorry, HoppyHour is not available"
  # end


  @@globalresults=[]
  def new
    @place = Place.new
  end

  def new_review
    @place=Place.find_by_id(params[:id]) || Place.find_by_id(params[:place_id])
    @review=Review.find_by_id(params[:review_id]) || Review.new
  end

  def new_review_save
    @review=Review.new(params[:review])
    @review.save
    redirect_to("/places/#{@review.place_id}")
  end

  def query_google_by_name
    @place = params[:search_term]
    search_query=(@place).downcase.strip.gsub(' ','+')
    #Send search query to google to find the location(Validate Location)
    val_loc=JSON.load(open("https://maps.googleapis.com/maps/api/place/textsearch/json?key=#{ENV["GOOGLE_API_KEY"]}&location=41.2918589,-96.0812485&radius=5000&query=#{search_query}&sensor=false"))

    return val_loc
  end

  def check_db
    val_loc=@@globalresults
    lat=params[:lat].gsub("e",".").to_f
    lng=params[:lng].gsub("e",".").to_f
    choice=params[:pos].to_i

    @check_db=Place.where({:lat=>lat, :lng=>lng}).first
    #If place is in db go to that page
    if @check_db
      redirect_to("/places/#{@check_db.id}")
    else
    #If the location is not a workhangout yet, we cann add it to the DB!
    @place=Place.new
      val_loc=@@globalresults
      @place.name = val_loc["results"][choice]["name"]
      format_address=val_loc["results"][choice]["formatted_address"]
      @place.street = format_address
      @place.lng=lng
      @place.lat=lat
      if val_loc["results"][choice]["photos"]!=nil
          @place.photoref=val_loc["results"][choice]["photos"][0]["photo_reference"]
      else
        @place.photoref=""
      end
      @place.save
      #Send user who created it to the page!
      redirect_to("/places/#{@place.id}")
      @user=current_user
    end
  end


   def new_manual
     #Google could not appease end user with results
     @place=Place.new
   end
 #
   def new_manual_save
     #Get params from user form to add a new place
     @place=Place.new(params[:place])
     #Get user address from form and format to send off for geocode
     unknown_address=("'#{@place.street}'+'#{@place.city}'+'#{@place.zipcode}'").strip.gsub(' ','+')
     #Send information to google for geocode, need lat/lng to place marker, user owns address
     unknown_loc=JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?address='#{unknown_address}'&sensor=false&key=#{ENV['GOOGLE_API_KEY']}"))
     #Get latitude and longitude from JSON string
     latitude=unknown_loc["results"][0]["geometry"]["location"]["lat"]
     longitude=unknown_loc["results"][0]["geometry"]["location"]["lng"]
     #Assign latitude and longitude to place variables
     @place.lat=latitude
     @place.lng=longitude
     #Save user created location to DB with geocode from google for lat/lng
     @place.save
  end

  def index
      gon.places=Place.all
      gon.group_people=[]
  end

  def results
    @place = params[:query]
    search_query=(@place).downcase.strip.gsub(' ','+')
    #Send search query to google to find the location(Validate Location)
    @val_loc=JSON.load(open("https://maps.googleapis.com/maps/api/place/textsearch/json?key=#{ENV["GOOGLE_API_KEY"]}&location=41.2918589,-96.0812485&radius=5000&query=#{search_query}&sensor=false"))
    @@globalresults=@val_loc
  end

  def show
    @place = Place.find_by_id(params[:id])
    lat = (@place.lat).to_s.gsub(".","e")
    lng = (@place.lng).to_s.gsub(".","e")
    #hh_response = JSON.load(open("http://hoppyhour.herokuapp.com/workhang/#{lat}/#{lng}"))
    begin
      x = open("http://hoppyhour.herokuapp.com/workhang/#{lat}/#{lng}")
    rescue OpenURI::HTTPError
      @message = "No HoppyHour Information Available, Add It Now!"
    else
      hh_response = JSON.load(x)
    end
    if !hh_response.blank?
      @beers = hh_response["beer"]
      @foods = hh_response["food"]
    end
    @present_people=Array.new
    @reviews=Review.where(:place_id => @place.id)
    @imgloc="https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{@place.photoref}&sensor=false&key=#{ENV['GOOGLE_API_KEY']}"
    @user = current_user
    if CheckIn.exists?(:place_id => @place.id, :time_out=>nil)
       @present=CheckIn.where(:place_id => @place.id, :time_out=>nil)
       i=0
       @present.each do |person_id|
         checked_in= person_id[:user_id]
         @present_people << User.find_by_id(checked_in)
         i+=1
       end
    else
       @present_people=[]
    end
    @user_checkins=CheckIn.where(:user_id => @user.id, :time_out => nil)
    @check_ins=CheckIn.where(:user_id => @user.id, :place_id => @place.id, :time_out => nil)
    check_admin ? @allow_edit=true : @allow_edit=false
  end

  def edit
    @place=Place.find(params[:id])
  end

  def update
    binding.pry
    @place=Place.find(params[:id])
    @place.update_attributes(params[:place])
    redirect_to(:root)
  end

  def destroy
    @place=Place.find(params[:id])
    @place.destroy
    redirect_to(:root)
  end

  #Return correctly formatted string of coordinates for locations in db by passing in id
  def deliver_coordinates(id)
    @created_place=Place.find_by_id(id)
    return coordinates="#{@created_place.lng},#{@created_place.lat}"
  end
  #Return name of location by passing in id
  def deliver_name(id)
    @created_place=Place.find_by_id(id)
    @created_place.name
  end

  #Return an array of objects where users are checked in currently, will run an each on to create js markers for google map(helper?)
  def deliver_checked_in
    @checked_in=Place.where(:occupied => true)
    return @checked_in
  end

end
