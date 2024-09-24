require 'sinatra/base'
require 'sinatra/reloader'
require 'uri'
require 'net/http'
require 'faraday'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    options = {
      url: 'https://api.publicapis.org'
    }
    conn = Faraday.new(options) do |f|
      f.response :json
      f.adapter :net_http
      f.request :url_encoded
    end

    res = conn.get('/categories')
    @categories = res.body['categories']

    req_params = {
    }
    req_params[:category] = params['category'] if params['category']
    req_params[:title] = params['title'] if params['title']

    res = conn.get('/entries', req_params)
    @list = res.body
    erb :index
  end
end
