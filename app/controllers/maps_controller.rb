class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [:show, :new]
  before_action :current_map, only: [:index, :show, :add_location]
  before_action :authenticate_google, only: [:add_location]

  def index
    @maps = policy_scope(Map)
  end

  def add_location
    authorize @map
    @markers = @client.spots_by_query(params[:query]).map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng
      }
    end

    ajax_request
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

  def ajax_request
    respond_to do |format|
      format.html
      format.js
    end
  end

  def current_map
    @map = Map.find(params[:id])
  end

  def authenticate_google
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
  end

  def map_params
    params.require(:map).permit(:name, :description, :photo, :query)
  end
end
