require 'grape'
require 'json'
require 'foursquare2'
require 'net/http'

class Category < Grape::API

prefix 'api'

resource :healthcheck  do
	get do
	  "healthcheck good"		
	end
end

resource :category do
	get do
		access_token = ENV['OAUTH_ACCESSTOKEN']
		v_date = ENV['V']
		uri = URI("https://api.foursquare.com/v2/venues/categories?oauth_token=#{access_token}&v=20150613")
	    Net::HTTP.get(uri)
	end
end

end
