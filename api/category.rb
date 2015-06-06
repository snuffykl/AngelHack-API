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
end
