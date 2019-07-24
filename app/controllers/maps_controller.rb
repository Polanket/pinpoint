class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [ :show ]
  def index
    @maps = policy_scope(Map)
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
  end

  def show
    @map = Map.find(params[:id])
  end
end
