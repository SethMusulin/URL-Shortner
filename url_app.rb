require 'sinatra/base'

class UrlApp < Sinatra::Application

  URL_DATA = []
  DOMAIN = ""

  get '/' do
    erb :homepage, :locals => {:urls => URL_DATA}
  end

  post '/' do
    full_url = params[:full_url]
    if !full_url.include? "http://"
      full_url.insert(0, "http://")
    end
    URL_DATA << full_url
    index = URL_DATA.find_index(full_url) + 1
    DOMAIN = request.url
    redirect "/#{index}?stats=true"
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