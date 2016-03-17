require 'net/http'
require 'json'

class PagesController < ApplicationController
  def home
    #ruby
    # http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=american+psycho
    url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=pizza"
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer) 
    # byebug
    @image = result["data"]["fixed_height_downsampled_url"]
  end
end