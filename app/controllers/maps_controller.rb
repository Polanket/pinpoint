class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]

  def index
    @maps = policy_scope(Map)
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
  end

  def add_location
    @markers = @client.spots_by_query('goiko grill near madrid').map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng
      }
    end
  end

  def show
    @map = Map.find(params[:id])
  end

  def new
    @map = Map.new
  end

  def create
    @map = Map.new(map_params)
    @map.user = current_user
    if map.save
      redirect_to user_map_path(current_user, @map)
    else
      render :new
    end
  end

  private

  def map_params
    params.require(:map).permit(:name, :description, :photo)
  end
end
