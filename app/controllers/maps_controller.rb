class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]
  before_action :current_map, only: [:index, :show, :save_marker, :results]
  before_action :authenticate_google, only: [:save_marker, :results]
  before_action :my_maps, only: [:show, :results]
  before_action :shared_maps, only: [:show, :results]

  def index
    @maps = policy_scope(Map)
  end

  def results
    authorize @map

    @markers = @client.spots_by_query(params[:query]).map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng,
        infoWindow: render_to_string(partial: 'info_window', locals: { spot: spot }),
        image_url: helpers.asset_url('new_location.png')
      }
    end
    my_locations.each do |location|
      @markers << location
    end
  end

  def save_marker
    authorize @map
    location = @client.spot(params[:marker_id])
    AddedLocation.create(
      map_id: @map.id,
      name: location.name,
      address: location.formatted_address,
      description: "Placeholder description",
      photo: location.photos[0].fetch_url(800),
      latitude: location.lat,
      longitude: location.lng
    )
    redirect_to map_path
  end

  def show
    @map = Map.find(params[:id])
    @markers = my_locations
  end

  def new
    @map = Map.new
    authorize @map
  end

  def create
    @map = Map.new(map_params)
    @map.user = current_user
    authorize @map
    if @map.save
      redirect_to new_map_user_group_path(@map)
    else
      render :new
    end
  end

  private

  def my_maps
    @my_maps = current_user.owned_maps
  end

  def shared_maps
    @shared_maps = current_user.shared_maps
  end

  def my_locations
    my_markers = @map.added_locations.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: 'added_info_window', locals: { spot: location }),
        image_url: helpers.asset_url('added_location.png')
      }
    end
    my_markers
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
