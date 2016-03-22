require 'net/http'
require 'json'

class PagesController < ApplicationController
  def home
    if user_signed_in?
      #ruby
      # http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=american+psycho
      url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=pizza"
      resp = Net::HTTP.get_response(URI.parse(url))
      buffer = resp.body
      result = JSON.parse(buffer)
      @rand_giphy_image = result["data"]["fixed_height_downsampled_url"]

      @pizzas = Pizza.all
      @users = User.all
      @slices = Slice.all
      @events = Event.all

      render file: '/app/views/pages/home-logged-in'
    else
      @slices = Slice.all
      @events = Event.all
      render file: '/app/views/pages/home-logged-out'
    end
  end
end
