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
      requires :payload, type: Hash, desc: "The payload consist of categoryids/latitude/longtitude/radius" do
        requires :lat, type: Float, values: -90.0..+90.0
        requires :lng, type: Float, values: -180.0..+180.0
        requires :categories, type: Array[String]
        optional :radius, type: Integer, default: 500
      end
    end

    post do
      access_token = ENV['OAUTH_ACCESSTOKEN']
      v_date = ENV['V']

      payload = params[:payload]
      latitude = payload["lat"]
      longtitude = payload["lng"]
      radius = payload["radius"]
      categories = payload["categories"]

      uri = URI("https://api.foursquare.com/v2/venues/search?categoryid=#{categories.join(',')}&intent=browse&ll=#{latitude},#{longtitude}&radius=#{radius}&oauth_token=#{access_token}&v=20150613")

      response = JSON.parse(Net::HTTP.get(uri))["response"]

      response['venues']
          .map do |c| 
            ['contact', 'location', 'name', 'url' ].map {  |i| { i.to_sym => c[i] } }
            .reduce { |r, i| r.merge i }
          end
          .to_json
    end
  end
end

