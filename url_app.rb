require 'sinatra/base'
require 'uri'

class UrlApp < Sinatra::Application

  URL_DATA = []
  DOMAIN = ""
  ERROR_MESSAGE = ""

  get '/' do
    erb :homepage, :locals => {:urls => URL_DATA, :error => ERROR_MESSAGE}
  end

  post '/' do
    full_url = params[:full_url]
    full_url.strip!
    if !full_url.include?("http://") && !full_url.include?("https://")
      full_url.insert(0, "http://")
    end
    if full_url =~ /^#{URI::regexp}$/ && full_url =~ /[a-zA-Z\d]['.'][a-zA-Z][a-zA-Z]/
      URL_DATA << full_url
      index = URL_DATA.find_index(full_url) + 1
      DOMAIN = request.url
      redirect "/#{index}?stats=true"
    else
      ERROR_MESSAGE = "The text you entered is not a valid URL"
      redirect '/'
    end
  end

  get '/:index' do
    old_url = URL_DATA[params[:index].to_i - 1]
    if params[:stats] == "true"
      index = params[:index]
      erb :new_link_page, :locals => {:old_url => old_url, :index => index, :domain => DOMAIN}
    else
      redirect to old_url
    end
  end
end