class MapsController < ApplicationController
  def index
    @maps = policy_scope(Map)
  end
end
