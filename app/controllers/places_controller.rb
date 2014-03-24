class PlacesController < ApplicationController
  respond_to :json, :js
  
  def new
    @place = Place.new
  end
  
  def create
    #need form from to search google api for json hash to parse into db here
    
    #User submitted a query to find a place:
    @place = Place.new(params[:place])
    #Assign search query submitted by user, format
    search_query=(@place.name).downcase.strip
    #Send search query to google to find the location(Validate Location)
    val_loc=JSON.load(open("https://maps.googleapis.com/maps/api/place/textsearch/json?location=41.2918589,-96.0812485&radius=50000&query=#{search_query}&sensor=false"))
    #Find lat/long from hash returned on the JSON request, assign to variables
    latidute=val_loc["results"][0]["geometry"]["location"]["lat"]
    longitude=val_loc["results"][0]["geometry"]["location"]["lng"]
    #Query server to find out if the location is in the database already,
    @check_db=Place.where({:lat=>latitude, :lng=>longitude}).first
    #If place is in db go to that page
    if @check_db
      redirect_to("/show/#{@check_db.id}")
      #Save the new location to the database using the information from google api as a helper
    else
      @place.name = val_loc["results"][0]["name"]
      format_address=val_loc["results"][0]["formatted_adress"].split(',')
      @place.street = format_address[0]
      @place.lng=longitude
      @place.lat=latitude
      @place.save
    end
  end
  
  def new_manual
    @name=params[:name]
  end
  
  def new_manual_save
    @place=Place.new(params[:place])
    unk_address=(@place.street+@place.city+@place.zip).strip.gsub('/ /','+')
    unknown_loc=JSON.load(open("http://maps.googleapis.com/maps/api/geocode/json?#address=#{unk_address},&sensor=false"))
    latidute=unknown_loc["results"][0]["geometry"]["location"]["lat"]
    longitude=unknown_loc["results"][0]["geometry"]["location"]["lng"]
    @place.lat=latitude
    @place.lng=longitude        
  end
  
  def index
    @places = Place.all
  end
  
  def show
    @places= Place.all
  end
  
  
end
#https://maps.googleapis.com/maps/api/place/radarsearch/json?location=51.503186,-0.126446&radius=5000&types=museum&sensor=false&key=AddYourOwnKeyHere
#GOOGLE API FOR TEXT PLACE SEARCH
##
#https://maps.googleapis.com/maps/api/place/textsearch/output?parameters
# where output may be either of the following values:
# 
#     json (recommended) indicates output in JavaScript Object Notation (JSON)
#     xml indicates output as XML
# 
# Certain parameters are required to initiate a search request. As is standard in URLs, all parameters are separated using the ampersand (&) character.
# 
# Required parameters
# 
#     query — The text string on which to search, for example: "restaurant". The Place service will return candidate matches based on this string and order the results based on their perceived relevance.
#     key — Your application's API key. This key identifies your application for purposes of quota management and so that Places added from your application are made immediately available to your app. Visit the APIs Console to create an API Project and obtain your key.
#     sensor — Indicates whether or not the Place request came from a device using a location sensor (e.g. a GPS) to determine the location sent in this request. This value must be either true or false.
# 
# Optional parameters
# 
#     location — The latitude/longitude around which to retrieve Place information. This must be specified as latitude,longitude. If you specify a location parameter, you must also specify a radius parameter.
#     radius — Defines the distance (in meters) within which to bias Place results. The maximum allowed radius is 50 000 meters. Results inside of this region will be ranked higher than results outside of the search circle; however, prominent results from outside of the search radius may be included.
#     language — The language code, indicating in which language the results should be returned, if possible. See the list of supported languages and their codes. Note that we often update supported languages so this list may not be exhaustive.
#     minprice and maxprice (optional) — Restricts results to only those places within the specified price level. Valid values are in the range from 0 (most affordable) to 4 (most expensive), inclusive. The exact amount indicated by a specific value will vary from region to region.
#     opennow — Returns only those Places that are open for business at the time the query is sent. Places that do not specify opening hours in the Google Places database will not be returned if you include this parameter in your query.
#     types — Restricts the results to Places matching at least one of the specified types. Types should be separated with a pipe symbol (type1|type2|etc). See the list of supported types.
#     zagatselected — Add this parameter (just the parameter name, with no associated value) to restrict your search to locations that are Zagat selected businesses. This parameter must not include a true or false value. The zagatselected parameter is experimental, and is only available to Places API enterprise customers.
# 
# You may bias results to a specified circle by passing a location and a radius parameter. This will instruct the Place service to prefer showing results within that circle; results outside of the defined area may still be displayed.
# 
# Maps API for Business customers should not include a client or signature parameter with their requests.
# 
# The below example shows a search for restaurants near Sydney.
# 
# https://maps.googleapis.com/maps/api/place/textsearch/xml?query=restaurants+in+Sydney&sensor=true&key=AddYourOwnKeyHere
# 
# Note that you'll need to replace the key in this example with your own key in order for the request to work in your application.
# Radar Search Requests
# 
# The Google Places API Radar Search Service allows you to search for up to 200 Places at once, but with less detail than is typically returned from a Text Search or Nearby Search request. With Radar Search, you can create applications that help users identify specific areas of interest within a geographic area. The search response will include up to 200 Places, identified only by their geographic coordinates and Place reference. You can send a Place Details request for more information about any of the Places in the response.
# 
# Radar Search shares the same usage limits and quota as Text Search and Nearby Search. However, the Radar Search Service is subject to a 5-times multiplier. That is, each Radar Search request that you make will count as 5 requests against your quota.
# 
# A Place Radar Search request is an HTTP URL of the following form:
# 
# https://maps.googleapis.com/maps/api/place/radarsearch/output?parameters
# 
# where output may be either of the following values:
# 
#     json (recommended) indicates output in JavaScript Object Notation (JSON)
#     xml indicates output as XML
# 
# Certain parameters are required to initiate a search request. As is standard in URLs, all parameters are separated using the ampersand (&) character.
# 
# Required parameters
# 
#     key — Your application's API key. This key identifies your application for purposes of quota management and so that Places added from your application are made immediately available to your app. Visit the APIs Console to create an API Project and obtain your key.
#     location — The latitude/longitude around which to retrieve Place information. This must be specified as latitude,longitude.
#     radius — Defines the distance (in meters) within which to return Place results. The maximum allowed radius is 50 000 meters.
#     sensor — Indicates whether or not the Place request came from a device using a location sensor (e.g. a GPS) to determine the location sent in this request. This value must be either true or false.
# 
# Optional parameters
# 
# A Radar Search request must include at least one of keyword, name, or types. Other parameters are completely optional.
# 
#     keyword — A term to be matched against all content that Google has indexed for this Place, including but not limited to name, type, and address, as well as customer reviews and other third-party content.
#     minprice and maxprice (optional) — Restricts results to only those places within the specified price level. Valid values are in the range from 0 (most affordable) to 4 (most expensive), inclusive. The exact amount indicated by a specific value will vary from region to region.
#     name — One or more terms to be matched against the names of Places, separated with a space character. Results will be restricted to those containing the passed name values. Note that a Place may have additional names associated with it, beyond its listed name. The API will try to match the passed name value against all of these names; as a result, Places may be returned in the results whose listed names do not match the search term, but whose associated names do.
