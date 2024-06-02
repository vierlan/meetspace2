class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.includes(:venue)
  end
  
  def create
    @venue = Venue.find(params[:venue_id])
    @favorite = current_user.favorites.build(venue: @venue)

    if @favorite.save
      redirect_to @venue, notice: 'Venue was successfully added to your favorites.'
    else
      redirect_to @venue, alert: 'Unable to add venue to favorites.'
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_to @favorite.venue, notice: 'Venue was successfully removed from your favorites.'
  end
end
