module PlacesHelper

  
  def show_checked_in
    @places=Place.all
    checked_in=@places.where(:occupied => true).each do |checked_in|
      #print  all javascript points that are checked-in into places.js.erb
    end
  end
  
  def show_all
      @places=Place.all
      @places.each do |place|
        #print all javascript points into places.js.erb
      end
  end
  def get_db
    @places=Place.all
  end
  
    
end
