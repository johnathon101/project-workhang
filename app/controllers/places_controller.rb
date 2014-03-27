class PlacesController < ApplicationController
  #Create methods to respond to js calls
  respond_to :json, :js
  
  @@globalresults=[]
  def new
    @place = Place.new
  end
  
  def stored_values(all_results)
  
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
     unknown_loc=JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?address=#{unknown_address}&sensor=false&key=#{ENV['GOOGLE_API_KEY']}"))
     binding.pry
     #Get latitude and longitude from JSON string
     latitude=unknown_loc["results"][0]["geometry"]["location"]["lat"]#unknown_loc["results"][0]["geometry"]["location"]["lat"]
     longitude=unknown_loc["results"][0]["geometry"]["location"]["lng"]#unknown_loc["results"][0]["geometry"]["location"]["lng"]
     #Assign latitude and longitude to place variables
     @place.lat=latitude
     @place.lng=longitude        
     #Save user created location to DB with geocode from google for lat/lng
     @place.save
     redirect_to("/places/#{@place.id}")
  end
  
  def index
    if option=-1
      gon.places=Place.all
    elsif option==2
      gon.places=Place.where(:checked_in => true)
    else
    #need variable to detect a group location only from user  
      gon.places=Place.where(:checked_in => true)
    #@places = Place.all
    end
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
    @imgloc="https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{@place.photoref}&sensor=false&key=#{ENV['GOOGLE_API_KEY']}"
    @user = current_user
    #@check_ins = current_user.check_ins.where(time_out: nil && place_id == @place.id)
    @reviews=Review.where(:place_id => @place.id)
  end
  
  def new_review
    @review=Review.new
    @place=Place.find_by_id(params[:place_id])
  end
  
  def new_review_save
    @review=Review.new(params[:review])
    @place=Place.find_by_id(params[:review][:place_id])
    @user=current_user
    @review.user_id=@user.id
    @review.place_id=@place.id
    @review.save
    redirect_to("/places/#{@place.id}")
  end
  
end