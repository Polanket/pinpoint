require 'google_places'

::GPClient = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
