class MapsController < ApplicationController
  def index
    @maps = policy_scope(Map)
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
  end
end
