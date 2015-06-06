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
      response = JSON.parse(Net::HTTP.get(uri))["response"]

      response['categories']
        .map { |c| {:id => c['id'], :name => c['name'], :pluralName => c['pluralName'], :shortName => c['shortName'] } }
        .to_json
    end
  end


resource :search do
	params do 
     requires :payload, type: Hash, desc: "The payload consist of categoryids/latitude/longtitude/radius"
   end

   post do
   		access_token = ENV['OAUTH_ACCESSTOKEN']
		v_date = ENV['V']
		payload = params[:payload]
		latitude = payload["latitude"]
		longtitude = payload["longtitude"]
		radius = payload["radius"]
		categories = payload["categories"]
		items = Hash.new 
		categories.each do |category|
			categoryid = category["categoryid"]
			item = category["item"]
			uri = URI("https://api.foursquare.com/v2/venues/search?categoryid=#{categoryid}&intent=browse&ll=#{latitude},#{longtitude}&radius=#{radius}&query=#{item}&oauth_token=#{access_token}&v=20150613")			
  			response = JSON.parse(Net::HTTP.get(uri))["response"]
  			items = {item => response}
   		end

  	   items
   end
end


end

