require 'open-uri'

module Espresso
  class IconsController < ApplicationController
    caches_page :show

    def show
      data = open "http://www.stdicon.com/crystal/#{params[:ctype]}?size=#{params[:size]}"
      send_data data.read, :type => data.content_type
    end

  end
end
