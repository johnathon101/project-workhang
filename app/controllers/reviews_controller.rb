class ReviewsController < ApplicationController

  def new
    @review=  Review.new
    @place=Place.find(params[:place_id])  
  end
  
  def update
    @review = Review.find(params[:id])
    @review.update_attributes(:content => params[:review][:content], :title=>params[:review][:title])
    @review.save
    redirect_to("/places/#{@review.place_id}")
  end
  
  def create
    @review=Review.new(params[:review])
    @review.user_id= current_user.id
    @review.save
    redirect_to("/places/#{@review.place_id}")
  end
  
  def destroy
    @review=Review.find(params[:id])
    @review.destroy
    redirect_to("/places/#{@review.place_id}")
  end 
  def show
    @review= Review.find(params[:id])
  end
  
    
  
end
