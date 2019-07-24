class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [ :show ]
  def index
    @maps = policy_scope(Map)
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
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


  def map_params
    params.require(:map).permit(:name, :description, :photo)
  end
end
