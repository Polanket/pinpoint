class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [ :show ]
  def index
    @maps = policy_scope(Map)
  end

  def show
    @map = Map.find(params[:id])
  end
end
